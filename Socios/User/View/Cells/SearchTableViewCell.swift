//
//  SearchTableViewCell.swift
//  Socios
//
//  Created by Akio Olvera on 9/25/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var seller: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
