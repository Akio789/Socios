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
    @IBOutlet weak var productComments: UITableView!
    
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
    var productCommentsA: Array<[String: Any]> = []
    var productId: String = ""
    
    struct Comment: Decodable {
        let user : String
        let text : String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db.collection("comments").whereField("productId", isEqualTo: productId).getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            var comments: Array<[String: Any]> = []
            if !querySnapshot!.isEmpty {
                comments = querySnapshot!.documents.first!.data()["comments"] as! Array<[String : Any]>
            }
            self.productCommentsA = comments
            }
        }
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return productCommentsA.count
        
    }
    
   /* func tableView(_ tableView: UITableView, cellForRowAt
                   indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: //"cell", for: indexPath)
       if let productCommentsA? = productCommentsA{
             cell.textLabel?.text = "\(productCommentsA[indexPath.row].user), \(productCommentsA[indexPath.row].text)"
              cell.textLabel?.numberOfLines = 0
           }
           return cell
      //  }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextView = segue.destination as! CommentsTableViewController
        nextView.productIdEntry = productId
    }
}
