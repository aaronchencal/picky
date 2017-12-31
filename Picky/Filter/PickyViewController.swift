//
//  PickyViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/30/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit

class PickyViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet var pickyView: PickyView!
    
    var fData : FilterData!
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.hidesBackButton = true
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
