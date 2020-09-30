//
//  QuestionDetailViewController.swift
//  Socios
//
//  Created by Akio Olvera on 9/19/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {

    
    @IBOutlet weak var preguntaLabel: UILabel!
    @IBOutlet weak var respuestaLabel: UILabel!
    
    var answerEntry: String = ""
    var questionEntry: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preguntaLabel.text = questionEntry
        respuestaLabel.text = answerEntry
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
