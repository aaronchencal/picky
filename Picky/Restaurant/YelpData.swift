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
    

    init(data: FilterData) {
        Alamofire.request("https://94f7e095.ngrok.io/info", parameters:
            ["latitude": "37.786882",
             "longitude" : "-122.399972",
             "price" : "1",
             "radius" : "1600",
             "categories" : "japanese,american,mexican,chinese"
            ]).responseJSON {
            response in
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                let decoder = JSONDecoder()
//                let myStruct = try! decoder.decode(myStruct.self, from: utf8Text)
//            }
            print(response.result.value)
        }
        
//        Alamofire.request(search, headers: headers).responseJSON { response in
//            if let json = response.result.value {
//                print("JSON: \(json)")
//            }
//        }
        
    }
    
}

