//
//  HighlightButton.swift
//  Picky
//
//  Created by Aaron Chen on 12/31/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit

class HighlightButton: UIButton {
    
    var color = UIColor.clear
    
    var isPicked = false
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
    }
    
    func turnOff() {
        isPicked = false
        backgroundColor = UIColor.clear
    }
    func turnOn() {
        isPicked = true
        backgroundColor = self.color
    }
    
    

}
