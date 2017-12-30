//
//  LoginViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/29/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func login(_ sender: UIButton) {
        guard let estring = emailField.text else {
            
            return
        }
        guard let pstring = passwordField.text else {
            
            return
        }
        Auth.auth().signIn(withEmail: estring, password: pstring) { (user, error) in
            
        }
    }

    func verifyEmail(emailString : String) -> Bool {
        return true
    }
    func verifyPassword(passwordString: String) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
