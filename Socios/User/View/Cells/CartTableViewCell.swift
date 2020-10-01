//
//  CartTableViewCell.swift
//  Socios
//
//  Created by Manuel Ortiz on 01/10/20.
//  Copyright © 2020 A01651395. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
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
