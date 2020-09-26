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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageUrl = URL(string: "http://martinmolina.com.mx/202013/Equipo3/assets/playeras/playera-polo-negro.png")
        let image = try? Data(contentsOf: imageUrl!)
        searchedImage.image = UIImage(data: image!)
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
