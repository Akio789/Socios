//
//  ContainerZoneProductsResultsViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 29/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase


class ContainerZoneProductsResultsViewController: UIViewController {
    @IBOutlet weak var mapa: MKMapView!
    var allUbications: [Any] = []
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 4000
    private var search: String = ""
    @IBOutlet weak var searchField: UITextField!
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    private func getNearByLandmarks(){
        //Local search request
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = search
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                
                //assign to landmarks. we want to assing it somewhere so we can display it on the map Landmark can be like a playera
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocationManager()
        getShopsPointAnnotations()
        

    }
    
    
    
    func setupLocationManager(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapa.setRegion(region, animated: true)
//            let marker = MKPointAnnotation()
//            marker.coordinate = location
//            marker.title = "Yo"
//            mapa.addAnnotation(marker)
        }
    }
    
    //MARK: - Stablish landmarks based on the sho ubications
    func getShopsPointAnnotations(){
//        let doc = Firestore.firestore().collection("tiendas")
        db.collection("tiendas").getDocuments() { [self] (querySnapshot, err ) in
            if let err = err {
                print("Error getting documents: \(err)")
            }else {
                for document in querySnapshot!.documents {
                    var title: String!
                    var point: GeoPoint!
                    if let names = document.get("name"){
                        title = (names as! String)
                    }
                    if let coords = document.get("localization"){
                        point = (coords as! GeoPoint)
                        let lat = point.latitude
                        let lon = point.longitude
                        let newMarker = MKPointAnnotation()
                        newMarker.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        newMarker.title = title as String
                        newMarker.subtitle = "."
                        self.mapa!.addAnnotation(newMarker)
                        
                    }
                    self.allUbications.append(["title": title as String, "latitude": point.latitude, "longitude": point.longitude])
                    
                }
                
            }
            self.mapa.showAnnotations(self.mapa.annotations, animated: true)
        }
        
//        for ubication in allUbications{
//            let annotation = MKPointAnnotation()
//            annotation.title = ubication["title"] as String
//            annotation.coordinate = CLLocationCoordinate2D(latitude: ubication["latitude"], longitude: ubication["longitude"])
//            mapa.addAnnotation(annotation)
//
//
//        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContainerZoneProductsResultsViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapa.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //wachito rico
    }
}
 
