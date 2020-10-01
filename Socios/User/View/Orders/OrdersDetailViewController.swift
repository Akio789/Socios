//
//  OrdersDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

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
    var orderDateEntry: String = ""
    var orderPrecioEntry : Double = 0
    var orderImageEntry : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: orderImageEntry) {
                   do {
                   //let contents = try String(contentsOf: url)
                   //print contents
                   let data = try? Data(contentsOf: url)
                   } catch {
                   // contents could not be loaded
                   print("contents could not be loaded")
                   }
            let image = try? Data(contentsOf: url)
            imageLabel.image = UIImage(data: image!)
               } else{
                   // the URL was bad!
                   print("the URL was bad!")
               }

        // Do any additional setup after loading the view.
        nameLabel.text = orderNameEntry
        vendedorLable.text = orderSellerEntry
        descripcionLabel.text = orderDescriptionEntry
        ratingLabel.text = String(orderRatingEntry)
        fechaLabel.text = orderDateEntry
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
