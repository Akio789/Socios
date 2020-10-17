//
//  RegisterViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var names: UITextField!
    @IBOutlet weak var lastNames: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var birthday: UIDatePicker!
    @IBOutlet weak var profilePicture: UIImageView!
    
    let db = Firestore.firestore()
    private let miPicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        names.text = ""
        lastNames.text = ""
        phone.text = ""
        miPicker.delegate = self
        profilePicture.image = UIImage(named: "ImagePlaceholder")
    }
    
    @IBAction func selectProfilePicture(_ sender: Any) {
        miPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(miPicker, animated: true, completion: nil)
    }
    
     func imagePickerController(_ picker: UIImagePickerController,
     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        profilePicture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        if names.text == "" || lastNames.text == "" || phone.text == "" {
            alertUser("Favor de llevar todos los campos.")
            return
        }
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){(user, error) in
            if error != nil{
                if let code = AuthErrorCode(rawValue: error!._code) {
                    var message = ""
                    switch code {
                    case .weakPassword:
                        message = "Tu contraseña es muy débil"
                    case .missingEmail:
                        message = "Ingresa tu email"
                    case .invalidEmail:
                        message = "Ingresa un email válido"
                    default:
                        message = error.debugDescription
                    }
                    self.alertUser(message)
                }
            }
            else{
                self.db.collection("users").document((user?.user.uid)!).setData([
                    "id": user?.user.uid,
                    "names": self.names.text,
                    "lastNames": self.lastNames.text,
                    "phone": self.phone.text,
                    "dob": self.birthday.date as! Date
                ]) { err in
                    if let err = err {
                        self.alertUser("Hubo un error, por favor intenta de nuevo.")
                    } else {
                        self.performSegue(withIdentifier: "registerSegue", sender: self)
                    }
                }
            }
            
        }
    }
    
    func alertUser(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Continuar", style: .default, handler: nil))
       self.present(alert, animated: true)
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
