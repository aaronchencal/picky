//
//  LaunchViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/22/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit
import FirebaseAuth

class LaunchViewController: UIViewController {

    @IBOutlet var launchView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var pickyLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Transparent navigation bar
        pickyLabel.layer.shadowOpacity = 0.95
        pickyLabel.layer.shadowColor = UIColor.black.cgColor
        pickyLabel.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes =  [ NSAttributedStringKey.font: UIFont(name: "SanFranciscoText-Regular", size: 20)!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

