//
//  ProductDetailViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var vendedorLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UITextView!
    @IBOutlet weak var califiacionLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var productDescriptionEntry: String = ""
    var productSellerEntry: String = ""
    var productPriceEntry: Double = 0
    var productRatingEntry: Double = 0
    var productimageUrl: String = ""
    var productCommentsA: [Any] = []
    var productNameA : String = ""
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

        // Do any additional setup after loading the view.
        productDescription.text = productDescriptionEntry
        precioLabel.text = "$" + String(productPriceEntry)
        vendedorLabel.text = productSellerEntry
        descripcionLabel.text = productDescriptionEntry
        califiacionLabel.text = String(productRatingEntry)
        nombreLabel.text = productNameA
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

