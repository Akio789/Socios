//
//  ShopsDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class ShopsDetailViewController: UIViewController {

    
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var descrpcionLabel: UILabel!
    @IBOutlet weak var fotoLabel: UIImageView!
    
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()
    
    var shopDescriptionEntry: String = ""
    var shopNameEntry: String = ""
    var shopImageURLEntry: String = ""
    var shopDirectionEntry: String = ""
    var shopPictureUrl: String = ""
    var shopId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderRef = self.storageRef.child(shopPictureUrl)
        self.orderRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error al bajar la foto: \(error)")
          } else {
            self.fotoLabel.image = UIImage(data: data!)
          }
        }

        // Do any additional setup after loading the view.
        nombreLabel.text = shopNameEntry
        direccionLabel.text = shopDirectionEntry
        descrpcionLabel.text = shopDescriptionEntry
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextView = segue.destination as! CommentsTableViewController
        nextView.shopIdEntry = shopId
    }

}
