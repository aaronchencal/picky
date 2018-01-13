//
//  FoodTableViewCell.swift
//  Picky
//
//  Created by Aaron Chen on 1/12/18.
//  Copyright © 2018 ACDev. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
