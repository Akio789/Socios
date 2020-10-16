//
//  LoginViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!){
                (user, error) in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Credenciales incorrectas.", preferredStyle: .alert)
                       
                    alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
                       
                    self.present(alert, animated: true)
                   }else{
                    self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
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
