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


class ContainerZoneProductsResultsViewController: UIViewController {
    @IBOutlet weak var mapa: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    private var search: String = ""
    @IBOutlet weak var searchField: UITextField!
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
 
