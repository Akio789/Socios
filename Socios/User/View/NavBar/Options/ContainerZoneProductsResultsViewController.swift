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
    let regionInMeters: Double = 3000
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
    }
    
    func setupLocationManager(){
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapa.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            //setup location manager
        }else{
            //Show alert letting the use know they have to turn this on
        }
    }
    
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            centerViewOnUserLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
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
 
