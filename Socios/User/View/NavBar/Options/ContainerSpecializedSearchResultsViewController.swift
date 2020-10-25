//
//  ContainerSpecializedSearchResultsViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/24/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class ContainerSpecializedSearchResultsViewController: UIViewController {

    @IBOutlet weak var searchedImage: UIImageView!
    var typeCategoryInput: String = ""
    var imageInput: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchedImage.image = imageInput
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! PersonalizedSearchResultTableViewController
        nextView.typeCategoryInput = typeCategoryInput
    }

}
