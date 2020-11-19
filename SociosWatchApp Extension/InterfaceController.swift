//
//  InterfaceController.swift
//  SociosWatchApp Extension
//
//  Created by Manuel Ortiz on 18/11/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet weak var mapa: WKInterfaceMap!
    var latitud = 0.0
    var longitud = 0.0
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session:WCSession, didReceiveMessage mensaje: [String : Any]){
        let latitud_s = mensaje["Latitud"] as! String
        let longitud_s = mensaje["Longitud"] as! String
        latitud = Double(latitud_s)!
        longitud = Double(longitud_s)!
        let centro = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        var region = MKCoordinateRegion(center: centro, latitudinalMeters: 500, longitudinalMeters: 500)
        self.mapa.setRegion(region)
        self.mapa.addAnnotation(centro, with: .green)
    }
    
    
    
    
    var miSesion : WCSession!
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        miSesion = WCSession.default
        miSesion.delegate = self
        miSesion.activate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
