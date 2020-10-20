//
//  UserProfileViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 22/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {

    var user = Auth.auth().currentUser
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var profilePicRef: StorageReference = StorageReference()
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        storageRef = storage.reference()
        profilePicRef = storageRef.child("\(user?.uid ?? "")/profilePic.jpg")
        profilePicRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error al bajar la foto: \(error)")
          } else {
            self.profilePicture.image = UIImage(data: data!)
          }
        }
        
    }

    @IBAction func deleteAccount(_ sender: Any) {
        var alert = UIAlertController(title: "¿Eliminar Perfil?", message: "Esta acción no se puede deshacer.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Eliminar", style: .default, handler: { (action: UIAlertAction!) in
            self.user?.delete { error in
          if let error = error {
            self.alertUser("Hubo un error al eliminar la cuenta, por favor intenta hacer logout y login de nuevo.")
          } else {
            self.performSegue(withIdentifier: "logout2", sender: self)
          }
        }
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action: UIAlertAction!) in
        // No hacer nada
        }))
        present(alert, animated: true, completion: nil)
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
