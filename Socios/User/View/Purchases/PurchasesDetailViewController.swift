//
//  PurchasesDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class PurchasesDetailViewController: UIViewController {
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var labelFoto: UIImageView!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var vendedorLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var ratingLable: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    
    var purchaseDescriptionEntry: String = ""
    var purchaseNameEntry: String = ""
    var purchaseSellerEntry: String = ""
    var purchaseRatingEntry: Double = 0
    var purchasePriceEntry: Double = 0
    var purchaseImageEntry: String = ""
    var purchaseFechaEntry: Date = Date()
    
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderRef = self.storageRef.child(purchaseImageEntry)
        self.orderRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error al bajar la foto: \(error)")
          } else {
            self.labelFoto.image = UIImage(data: data!)
          }
        }
        
        nombreLabel.text = purchaseNameEntry
        precioLabel.text = "$ " + String(purchasePriceEntry)
        vendedorLabel.text = purchaseSellerEntry
        descripcionLabel.text = purchaseDescriptionEntry
        ratingLable.text = String(purchaseRatingEntry)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        fechaLabel.text = formatter.string(from: purchaseFechaEntry)
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
