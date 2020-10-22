//
//  OrdersDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class OrdersDetailViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var vendedorLable: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    
    var orderDescriptionEntry: String = ""
    var orderNameEntry: String = ""
    var orderSellerEntry: String = ""
    var orderRatingEntry: Double = 0
    var orderDateEntry: Date = Date()
    var orderPrecioEntry : Double = 0
    var orderImageEntry : String = ""
    
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderRef = self.storageRef.child(orderImageEntry)
        self.orderRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error al bajar la foto: \(error)")
          } else {
            self.imageLabel.image = UIImage(data: data!)
          }
        }

        // Do any additional setup after loading the view.
        nameLabel.text = orderNameEntry
        vendedorLable.text = orderSellerEntry
        descripcionLabel.text = orderDescriptionEntry
        ratingLabel.text = String(orderRatingEntry)
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        fechaLabel.text = formatter.string(from: orderDateEntry)
        priceLabel.text = "$" + String(orderPrecioEntry)
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
