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

    private var yData: YelpData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(fData.description)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveData(data: FilterData) {
        fData = data
        fData.persist()
        yData = YelpData(data: fData)
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
