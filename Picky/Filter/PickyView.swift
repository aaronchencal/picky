//
//  PickyView.swift
//  Picky
//
//  Created by Aaron Chen on 12/30/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit

class PickyView: UIView {

    @IBOutlet weak var walkButton: HighlightButton!
    @IBOutlet weak var driveButton: HighlightButton!
    
    @IBOutlet var priceButtons: [HighlightButton]!
    
    @IBAction func didPressWalkButton(_ sender: HighlightButton) {
        driveButton.turnOff()
        walkButton.turnOn()
    }
    
    @IBAction func didPressDriveButton(_ sender: HighlightButton) {
        walkButton.turnOff()
        driveButton.turnOn()
    }
    
    @IBAction func didPressPriceButton(_ sender: HighlightButton) {
        for button in priceButtons {
            button.turnOff()
        }
        sender.turnOn()
    }
    
    func setDefaults(data: FilterData) {
        walkButton.color = UIColor.red
        driveButton.color = UIColor.red
        for button in priceButtons {
            button.color = UIColor.green
        }
        data.isDriving ? driveButton.turnOn() :  walkButton.turnOn()
        for button in priceButtons {
            if button.tag == data.price.rawValue {
                	button.turnOn()
            }
        }
    }
    
    func exportFilter() -> (Bool, Price) {
        // (isDriving, price)
        for button in priceButtons {
            if button.isPicked {
                var p  = Price.cheap
                switch button.tag {
                case 1: p = .cheap
                case 2: p = .medium
                case 3: p = .expensive
                default: p = .cheap
                }
                return (driveButton.isPicked, p )
            }
        }
        return (false, .cheap)
    }
    
}
