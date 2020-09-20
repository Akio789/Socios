//
//  DetallePokemonViewController.swift
//  Socios
//
//  Created by user180478 on 9/7/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class DetallePokemonViewController: UIViewController {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descripcion: UITextView!
    
    var tituloEntrada: String = ""
    var descripcionEntrada: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titulo.text = tituloEntrada
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
