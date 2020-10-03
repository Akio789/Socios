//
//  PurchasesDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

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
    var purchaseFechaEntry: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: purchaseImageEntry) {
                   do {
                   //let contents = try String(contentsOf: url)
                   //print contents
                   let data = try? Data(contentsOf: url)
                   } catch {
                   // contents could not be loaded
                   print("contents could not be loaded")
                   }
            let image = try? Data(contentsOf: url)
            labelFoto.image = UIImage(data: image!)
               } else{
                   // the URL was bad!
                   print("the URL was bad!")
               }
        
        nombreLabel.text = purchaseNameEntry
        precioLabel.text = "$ " + String(purchasePriceEntry)
        vendedorLabel.text = purchaseSellerEntry
        descripcionLabel.text = purchaseDescriptionEntry
        ratingLable.text = String(purchaseRatingEntry)
        fechaLabel.text = purchaseFechaEntry
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
