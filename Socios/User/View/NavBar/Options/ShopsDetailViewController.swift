//
//  ShopsDetailViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 24/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class ShopsDetailViewController: UIViewController {

    
    
    @IBOutlet weak var shopDescription: UITextView!
    var shopDescriptionEntry: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        shopDescription.text = shopDescriptionEntry
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