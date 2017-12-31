//
//  Extensions.swift
//  Picky
//
//  Created by Aaron Chen on 12/30/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    /* https://stackoverflow.com/questions/29428402/creating-a-textfield-with-only-bottom-line-in-ios
    */
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
