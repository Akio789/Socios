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
    
    var productDescriptionEntry: String = ""
    var productSellerEntry: String = ""
    var productPriceEntry: Double = 0
    var productRatingEntry: Double = 0
    var productimageUrl: String = ""
    var productNameA: String = ""
    
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
               } else{
                   // the URL was bad!
                   print("the URL was bad!")
               }
        

        //let imageUrl = URL(string: productObject["imageUrl"] as! String)
        //let image = try? Data(contentsOf: imageUrl!)
        
        
        
        productDescription.text = productDescriptionEntry
        productSeller.text = productSellerEntry
        productPrice.text = String(productPriceEntry)
        productName.text = productNameA
        //productImage.cellImage.image = UIImage(data: image!)
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
