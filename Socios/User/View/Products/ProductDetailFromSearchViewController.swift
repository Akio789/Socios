//
//  ProductDetailFromSearchViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class ProductDetailFromSearchViewController: UIViewController {

    
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productSeller: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var prodcuRating: UILabel!
    @IBOutlet weak var productComments: UITableView!
   
    
    var productDescriptionEntry: String = ""
    var productSellerEntry: String = ""
    var productPriceEntry: Double = 0
    var productRatingEntry: Double = 0
    var productimageUrl: String = ""
    var productNameA: String = ""
    var productCommentsA: Array<[String: Any]> = []
    
    struct Comment: Decodable {
        let user : String
        let text : String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: productimageUrl) {
                   do {
                   //let contents = try String(contentsOf: url)
                   //print contents
                   let data = try? Data(contentsOf: url)
                   } catch {
                   // contents could not be loaded
                   print("contents could not be loaded")
                   }
            let image = try? Data(contentsOf: url)
            productImage.image = UIImage(data: image!)
               } else{
                   // the URL was bad!
                   print("the URL was bad!")
               }

        

        //let imageUrl = URL(string: productObject["imageUrl"] as! String)
        //let image = try? Data(contentsOf: imageUrl!)
        
        //productComments.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //productComments.dataSource = self
        
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
        nextView.commentsEntry = productCommentsA
    }
}
