//
//  DeleteProfileViewController.swift
//  Socios
//
//  Created by Manuel Ortiz on 22/09/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class DeleteProfileViewController: UIViewController {

    @IBOutlet weak var screen: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        screen.image = UIImage(named: "DeleteProfile")
        
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
