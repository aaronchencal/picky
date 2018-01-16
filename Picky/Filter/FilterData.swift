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
    
    var image : UIImage!
    
    init(n : String) {
        name = n
    }
}

class FilterData {
    
    var databaseRef: DatabaseReference!
    
    var yelpRestaurants = [ "tradamerican", "chinese", "hotdogs", "french","indpak", "italian", "japanese", "korean", "mediterranean", "mexican", "poutineries", "sandwiches", "seafood", "soulfood", "spanish", "steak", "taiwanese", "vietnamese"]
    
    var names = [ "tradamerican" : "American", "chinese" : "Chinese", "hotdogs" : "Fast Food", "french" : "French" ,"indpak" : "Indian", "italian" : "Italian", "japanese" : "Japanese", "korean" : "Korean", "mediterranean" : "Mediterranean", "mexican" : "Mexican", "poutineries" : "Poutine" , "sandwiches" : "Sandwiches", "seafood" : "Seafood", "soulfood" : "Soul Food", "spanish" : "Spanish", "steak" : "Steak", "taiwanese" : "Taiwanese", "vietnamese" : "Vietnamese" ]
    
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
    
    var restaurantString : String {
        get {
            var retString = data[0].name
            for dat in data {
                if dat.name == data[0].name || dat.checked {
                    continue
                }
                retString += ",\(dat.name)"
            }
            print("retstring: \(retString)")
            return retString
        }
    }
    
    var parameters: [String: String] {
        get {
            var dict = [String: String]()
            if let loc = self.location {
                dict["longitude"] = "\(loc.coordinate.longitude)"
                dict["latitude"] = "\(loc.coordinate.latitude)"
                dict["price"] = "\(price.rawValue)"
                dict["radius"] = isDriving ? "16000" : "1600"
                dict["categories"] = restaurantString
            } else {
                print("Error: location not found.")
            }
            return dict
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
//            str += "\nLocation: \(locationDescription!)"
          
            return str
        }
    }
    
    func getFilterItemAt(index: Int) -> FilterItem {
        return data[index]
    }
    
    func uncheckAll() {
        for item in data {
            item.checked = false
        }
    }

    private var finishedLoad = false
    
    func load(completion: @escaping (_: Bool) -> Void) {
        let user = AppDelegate.currentUser!
        var hadRestaurants = false
        
        databaseRef.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
            self.finishedLoad = true
            // Get user value
            if snapshot.exists() {
                let value = snapshot.value as! NSDictionary
                self.isDriving = (value["isdriving"] as! Int) == 1 ? true : false
                let pric = (value["price"] as! Int)
                hadRestaurants = true
                
                if let restaurants = value["restaurants"] as? NSArray {
                    self.uncheckAll()
                    for item in self.data {
                        for rest in restaurants {
                            if item.name == rest as! String{
                                item.checked = true
                                break
                            }
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
            completion(hadRestaurants)
            // ...
        }) { (error) in
            completion(false)
            print(error.localizedDescription)
        }
        Timer.scheduledTimer(withTimeInterval: TimeInterval(3.0), repeats: false) { timer in
            if !self.finishedLoad {
                completion(false)
            }
        }
      
    }
    
    func persist() {
        let user = AppDelegate.currentUser!
        var arr = [String]()
        for filterItem in data {
            if filterItem.checked {
                arr.append(filterItem.name)
            }
        }
        print(user.uid)
        self.databaseRef.child("users/\(user.uid)/restaurants").setValue(arr)
        self.databaseRef.child("users/\(user.uid)/isdriving").setValue(isDriving ? 1 : 0)
        self.databaseRef.child("users/\(user.uid)/price").setValue(price.rawValue)
    }
    
    func canCheckMore() -> Bool {
        var count = 0
        for filterItem in data {
            if filterItem.checked {
                count += 1
            }
        }
        return count < self.count - 1
    }
    
}

