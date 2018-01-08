//
//  RestaurantViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/31/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {

    private var yData: YelpData.Restaurant!
    
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tempLabel.text =
        """
        name: \(yData.name)\n
        place: \(yData.location.display_address)\n
        category: \(yData.rating)
        """
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func receiveData(data: YelpData.Restaurant) {
            yData = data
            print(yData)
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
