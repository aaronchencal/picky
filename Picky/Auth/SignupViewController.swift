//
//  SignupViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/29/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn 

class SignupViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet var signupView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    private var googleDelegate : GoogleDelegate!
    
    @IBAction func signup(_ sender: UIButton) {
      
        let estring = emailField.text
        let pstring = passwordField.text
        
        if !verifyEmail(emailString: estring) || !verifyPassword(passwordString: pstring) {
            return
        }
        
        spinner.isHidden = false
        spinner.startAnimating()
//        for view in self.signupView.subviews {
//            if view.tag == 0 {
//                view.isHidden = true
//            }
//        }
        Auth.auth().createUser(withEmail: estring!, password: pstring!) { (user, error) in
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
//            for view in self.signupView.subviews {
//                if view.tag == 0 {
//                    view.isHidden = false
//                }
//            }
            if let err = error as NSError? {
                guard let err = AuthErrorCode(rawValue: err.code) else {
                    self.errorLabel.text = "Unknown error signing up"
                    return
                }
                switch err {
                case .invalidEmail:
                    self.errorLabel.text = "Invalid email"
                default:
                    self.errorLabel.text = "Invalid email"
                }
            } else {
                //login successful
                
            }
        }
    }
    
    func verifyEmail(emailString : String?) -> Bool {
        guard let emailString = emailString else {
            return false
        }
        if emailString == "" {
            self.errorLabel.text = "Please enter an email"
            return false
        }
        return true
    }
    func verifyPassword(passwordString: String?) -> Bool {
        guard let passwordString = passwordString else {
            return false
        }
        if passwordString.count < 6 {
            self.errorLabel.text = "Password too short!"
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        errorLabel.text = ""
        googleDelegate = GoogleDelegate(view: signupView, spinner: spinner)
        GIDSignIn.sharedInstance().delegate = googleDelegate
        GIDSignIn.sharedInstance().uiDelegate = self
        emailField.useUnderline()
        passwordField.useUnderline()    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}

