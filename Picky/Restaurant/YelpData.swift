//
//  YelpData.swift
//  Picky
//
//  Created by Aaron Chen on 1/2/18.
//  Copyright © 2018 ACDev. All rights reserved.
//

import Foundation
import Alamofire

class YelpData {
    
    struct Restaurant: Codable {
        let name: String
        struct Coordinates: Codable {
            let longitude: Double
            let latitude: Double
        }
        let coordinates: Coordinates
        let rating: Double
        let price: String
        let review_count: Int
        struct Location: Codable {
            let display_address: [String]
        }
        let location: Location
        let id: String
        struct Category: Codable {
            let title : String
        }
        let categories : [Category]
        let image_url: String
        let url: String
    }

    init(data: FilterData) {
        Alamofire.request("https://92248ce4.ngrok.io/info", parameters:
            ["latitude": "37.786882",
             "longitude" : "-122.399972",
             "price" : "1",
             "radius" : "1600",
             "categories" : "japanese,american,mexican,chinese"
            ]).responseJSON {
            response in
            if let data = response.data {
                let decoder = JSONDecoder()
                let restStruct = try! decoder.decode(Restaurant.self, from: data)
                print(restStruct)
            }
//            print(response.result.value)
        }
        
//        Alamofire.request(search, headers: headers).responseJSON { response in
//            if let json = response.result.value {
//                print("JSON: \(json)")
//            }
//        }
        
    }
    
}

