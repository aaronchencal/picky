//
//  FilterData.swift
//  Picky
//
//  Created by Aaron Chen on 12/30/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import Foundation

class FilterItem {
    var checked = false
    var name = "placeholder"
    
    init(n : String) {
        name = n
    }
}

class FilterData {
    
    var yelpRestaurants = ["American", "Chinese", "Pizza", "Zimbabwe"]
    
    var data = [FilterItem]()
    
    init() {
        for restnt in yelpRestaurants {
            data.append(FilterItem(n: restnt))
        }
    }
    
    var count : Int {
        get {
            return data.count
        }
    }
    
    func getFilterItemAt(index: Int) -> FilterItem {
        return data[index]
    }


}
