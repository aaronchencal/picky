//
//  FilterData.swift
//  Picky
//
//  Created by Aaron Chen on 12/30/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

enum Price : Int {
    case cheap = 1
    case medium = 2
    case expensive = 3
}

class FilterItem {
    var checked = false
    var name = "placeholder"
    
    init(n : String) {
        name = n
    }
}

class FilterData {
    
    var databaseRef: DatabaseReference!
    
    var yelpRestaurants = ["American", "Chinese", "Pizza", "Zimbabwe"]
    
    var data = [FilterItem]()
    
    var isDriving = false
    
    var price = Price.cheap
    
    var location: CLLocation! {
        didSet {
            let coder = CLGeocoder()
            coder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let pl = placemarks {
                    for placemark in pl {
                        self.locationDescription = "\(placemark.locality!), \(placemark.administrativeArea!)"
                    }
                }
            }
        }
    }
    
    init() {
        for restnt in yelpRestaurants {
            data.append(FilterItem(n: restnt))
        }
        databaseRef = Database.database().reference()
    }
    
    var count : Int {
        get {
            return data.count
        }
    }
    
    var locationDescription : String!
    
    var description : String {
        get {
            var str = ""
            str += "price: \(price) isDriving: \(isDriving) \n Restaurants: "
            for index in 0..<count {
                let fItem = getFilterItemAt(index: index)
                if !fItem.checked {
                    str  += "\(fItem.name), "
                }
            }
            str += "\nLocation: \(locationDescription!)"
          
            return str
        }
    }
    
    func getFilterItemAt(index: Int) -> FilterItem {
        return data[index]
    }
    
    func checkAll() {
        for item in data {
            item.checked = true
        }
    }

    func load(view: UITableView) {
        let user = AppDelegate.currentUser!
        databaseRef.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if snapshot.exists() {
            let value = snapshot.value as! NSDictionary
            self.isDriving = (value["isdriving"] as! Int) == 1 ? true : false
            let restaurants = value["restaurants"] as! NSArray
            let pric = (value["price"] as! Int)
            self.checkAll()
            for item in self.data {
                for rest in restaurants {
                    if item.name == rest as! String{
                        item.checked = false
                        break
                    }
                }
            }
            switch pric {
            case 1: self.price = Price.cheap
            case 2: self.price = Price.medium
            case 3: self.price = Price.expensive
            default: self.price = Price.cheap
            }
            }
            view.reloadData()
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    func persist() {
        let user = AppDelegate.currentUser!
        var arr = [String]()
        for filterItem in data {
            if !filterItem.checked {
                arr.append(filterItem.name)
            }
        }
        print(user.uid)
        self.databaseRef.child("users/\(user.uid)/restaurants").setValue(arr)
        self.databaseRef.child("users/\(user.uid)/isdriving").setValue(isDriving ? 1 : 0)
        self.databaseRef.child("users/\(user.uid)/price").setValue(price.rawValue)
    }
}

