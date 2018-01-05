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
    
    
    private var search = "https://api.yelp.com/v3/businesses/search?term=delis&latitude=37.786882&longitude=-122.399972"
    
    let headers: HTTPHeaders = ["Authorization": "Bearer YlKUGWyaCVEtyephYkCQ-kO93QPjopvsTzJLUa5k1CQwaoicJfCBIai8-4_CcVEvET1KdAliZyqHcZs43t92nvkB8BXcLPyXlUUmYjxUXgmj7mL4tu5wqt0Nd3BMWnYx"]
    
    var respresult : Any?
    init() {
        Alamofire.request("https://24490acf.ngrok.io/api/get", parameters: ["latitude": "37.786882", "longitude" : "-122.399972"],  headers: headers).responseJSON {
            response in
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                let decoder = JSONDecoder()
//                let myStruct = try! decoder.decode(myStruct.self, from: utf8Text)
//            }
            
        }
        
//        Alamofire.request(search, headers: headers).responseJSON { response in
//            if let json = response.result.value {
//                print("JSON: \(json)")
//            }
//        }
        
    }
    
}

