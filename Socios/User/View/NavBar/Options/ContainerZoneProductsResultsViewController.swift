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

class ContainerZoneProductsResultsViewController: UIViewController, CLLocationManagerDelegate {
    let ubicacion = CLLocationManager()
    //@IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        /*super.viewDidLoad()
        ubicacion.delegate = self
        ubicacion.desiredAccuracy = kCLLocationAccuracyBest
        ubicacion.requestWhenInUseAuthorization()
        let centro = CLLocationCoordinate2D(latitude: 19.3521753, longitude: -99.1561553)
        mapa.region = MKCoordinateRegion(center: centro, latitudinalMeters: 500, longitudinalMeters: 500)
        let marcador = MKPointAnnotation()
        marcador.coordinate = centro
        mapa.addAnnotation(marcador)*/
        
        // Do any additional setup after loading the view.
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
