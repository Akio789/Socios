//
//  PurchasesDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class PurchasesDetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var purchaseDescription: UITextView!
    @IBOutlet weak var purchaseNombre: UILabel!
    @IBOutlet weak var purchasePrecio: UILabel!
    @IBOutlet weak var purchaseSeller: UILabel!
    @IBOutlet weak var purchaseRating: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    
    var purchaseDescriptionEntry: String = ""
    var purchaseNameEntry : String = ""
    var purchaseSellerEntry: String = ""
    var purchaseRatingEntry: Double = 0
    var purchaseDateEntry: String = ""
    var purchasePriceEntry : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        purchaseDescription.text = purchaseDescriptionEntry
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
