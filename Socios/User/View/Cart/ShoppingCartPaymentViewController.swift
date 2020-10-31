//
//  ShoppingCartPaymentViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 22/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import LocalAuthentication

class ShoppingCartPaymentViewController: UIViewController {

    @IBOutlet weak var screen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        screen.image = UIImage(named: "ShoppingCartPayment")
    }
    
    @IBAction func authenticaBiometrics(_ sender: Any) {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Mensaje", reply: {
            (success, err) in
                if (err != nil) {
                    print("Error al autenticar")
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ConfirmedPurchase", sender: self)
                    }
                }
            })
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
