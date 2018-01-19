//
//  Extensions.swift
//  Picky
//
//  Created by Aaron Chen on 12/30/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import Foundation
import UIKit

/* https://stackoverflow.com/questions/42545955/scale-image-to-smaller-size-in-swift3 */
extension UIImage{
    
    func resize(newSize: CGSize) -> UIImage {
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

}
/*
 https://stackoverflow.com/questions/35946499/how-to-truncate-decimals-to-x-places-in-swift
 */
extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
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
