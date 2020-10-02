//
//  PurchasesDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class PurchasesDetailViewController: UIViewController {
    
    
    
//    @IBOutlet weak var purchaseDescription: UITextView!
//    @IBOutlet weak var purchaseNombre: UILabel!
//    @IBOutlet weak var imageLabel: UIImageView!
//    @IBOutlet weak var precioLabel: UILabel!
//    @IBOutlet weak var vendedorLabel: UILabel!
//    @IBOutlet weak var ratingLabel: UILabel!
//    @IBOutlet weak var fechaLabel: UILabel!
//
    
    var purchaseDescriptionEntry: String = ""
    var purchaseNameEntry : String = ""
    var purchaseSellerEntry: String = ""
    var purchaseRatingEntry: Double = 0
    var purchaseDateEntry: String = ""
    var purchasePriceEntry : Double = 0
    var purchaseImageEntry : String = ""
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let url = URL(string: purchaseImageEntry) {
//                   do {
//                   //let contents = try String(contentsOf: url)
//                   //print contents
//                   let data = try? Data(contentsOf: url)
//                   } catch {
//                   // contents could not be loaded
//                   print("contents could not be loaded")
//                   }
//            let image = try? Data(contentsOf: url)
//            imageLabel.image = UIImage(data: image!)
//               } else{
//                   // the URL was bad!
//                   print("the URL was bad!")
//               }

        // Do any additional setup after loading the view.
//        purchaseDescription.text = purchaseDescriptionEntry
//        purchaseNombre.text = purchaseNameEntry
//        precioLabel.text =  String(purchasePriceEntry)
//        vendedorLabel.text = purchaseSellerEntry
//        ratingLabel.text = String(purchaseRatingEntry)
//        fechaLabel.text = purchaseDateEntry
        
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
