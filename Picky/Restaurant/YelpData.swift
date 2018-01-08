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

    var fData: FilterData!
    
    func makeRequest(completion: @escaping (Restaurant?, Bool) -> Void) {
        Alamofire.request("https://sspicky.vapor.cloud/info", parameters: fData.parameters
            ).responseJSON {
                response in
                if let data = response.data {
                    let decoder = JSONDecoder()
                    do {
                        let restStruct = try decoder.decode(Restaurant.self, from: data)
                        completion(restStruct, true)
                    } catch {
                        print("Error: \(error)")
                    }
                }
                completion(nil, false)
        }
    }
    
    init(data: FilterData) {
        fData = data
    }
    
}

