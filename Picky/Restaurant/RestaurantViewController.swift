//
//  RestaurantViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/31/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    private var fData: FilterData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("price: \(fData.price) \n isDriving: \(fData.isDriving)")
        for index in 0..<fData.count {
            let fItem = fData.getFilterItemAt(index: index)
            if fItem.checked {
                print("\(fItem.name)")
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveData(data: FilterData) {
        fData = data
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
