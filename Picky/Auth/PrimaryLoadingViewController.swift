//
//  PrimaryLoadingViewController.swift
//  Picky
//
//  Created by Aaron Chen on 1/10/18.
//  Copyright © 2018 ACDev. All rights reserved.
//

import UIKit

class PrimaryLoadingViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        spinner.isHidden = true
        spinner.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.performSegue(withIdentifier: "tomain", sender: self)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        spinner.stopAnimating()
    }
 

}
