//
//  ProductDetailFromSearchViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit
import Firebase

class ProductDetailFromSearchViewController: UIViewController {

    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productSeller: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var prodcuRating: UILabel!
    
    let db = Firestore.firestore()
    var user = Auth.auth().currentUser
    let storage = Storage.storage()
    var storageRef: StorageReference = StorageReference()
    var orderRef: StorageReference = StorageReference()
   
    
    var productDescriptionEntry: String = ""
    var productSellerEntry: String = ""
    var productPriceEntry: Double = 0
    var productRatingEntry: Double = 0
    var productimageUrl: String = ""
    var productNameA: String = ""
    var productId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderRef = self.storageRef.child(productimageUrl)
        self.orderRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {
            print("Error al bajar la foto: \(error)")
          } else {
            self.productImage.image = UIImage(data: data!)
          }
        }
        
        productDescription.text = productDescriptionEntry
        productSeller.text = productSellerEntry
        productPrice.text = "$" + String(productPriceEntry)
        productName.text = productNameA
        prodcuRating.text = String(productRatingEntry)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextView = segue.destination as! CommentsTableViewController
        nextView.productIdEntry = productId
    }
}
