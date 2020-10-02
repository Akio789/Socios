//
//  ShopsDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class ShopsDetailViewController: UIViewController {

    
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var descrpcionLabel: UILabel!
    @IBOutlet weak var fotoLabel: UIImageView!
    
    
    var shopDescriptionEntry: String = ""
    var shopNameEntry: String = ""
    var shopImageURLEntry: String = ""
    var shopCommentsEntry: Array<[String: Any]> = []
    var shopDirectionEntry: String = ""
    var shopPictureUrl: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: shopPictureUrl) {
                   do {
                   //let contents = try String(contentsOf: url)
                   //print contents
                   let data = try? Data(contentsOf: url)
                   } catch {
                   // contents could not be loaded
                   print("contents could not be loaded")
                   }
            let image = try? Data(contentsOf: url)
            fotoLabel.image = UIImage(data: image!)
               } else{
                   // the URL was bad!
                   print("the URL was bad!")
               }

        // Do any additional setup after loading the view.
        nombreLabel.text = shopNameEntry
        direccionLabel.text = shopDirectionEntry
        descrpcionLabel.text = shopDescriptionEntry
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let nextView = segue.destination as! CommentsTableViewController
        nextView.commentsEntry = shopCommentsEntry
    }

}
