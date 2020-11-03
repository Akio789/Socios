//
//  ContainerCartViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 01/10/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import LocalAuthentication
import FirebaseFirestore
import Social
import Firebase

class ContainerCartViewController: UIViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()

    override func viewDidLoad() {
        super.viewDidLoad()
        getTotalPrice()
        // Do any additional setup after loading the view.
    }
    
    func getTotalPrice(){
        db.collection("carts").whereField("user", isEqualTo: user!.uid).getDocuments() {
            (querySnapshot, err)
            in guard let querySnapshot = querySnapshot else {
                print("error")
                return
            }
            if !querySnapshot.isEmpty && querySnapshot.documents.count > 0 {
                //Add to user Cart
                let cartInfo = querySnapshot.documents.first?.data()
                let totalPrice = cartInfo?["total"] as! Double
                self.totalLabel.text = "\(totalPrice)"
                return
            }else {
                print("Error")
                return
            }
        }
        return
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
