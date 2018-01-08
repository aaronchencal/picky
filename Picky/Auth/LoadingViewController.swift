//
//  LoadingViewController.swift
//  Picky
//
//  Created by Aaron Chen on 1/7/18.
//  Copyright © 2018 ACDev. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    var data: FilterData!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = FilterData()
        data.load {
            self.actIndicator.stopAnimating()
            self.performSegue(withIdentifier: "nav", sender: self)
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController {
            if let childVC = navVC.topViewController as? FoodTableViewController {
                childVC.fData = data
            }
        }
       
    }

}
