//
//  LoginViewController.swift
//  Picky
//
//  Created by Aaron Chen on 12/29/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var googleDelegate : GoogleDelegate!
    
    @IBOutlet var loginView: UIView!
    
    
    @IBAction func login(_ sender: UIButton) {
        let estring = emailField.text
        let pstring = passwordField.text
        
        if !verifyEmail(emailString: estring) || !verifyPassword(passwordString: pstring) {
            return
        }
        actIndicator.isHidden = false
        actIndicator.startAnimating()
        for view in loginView.subviews {
            if view.tag == 0 {
                view.isHidden = true
            }
        }
        Auth.auth().signIn(withEmail: estring!, password: pstring!) { (user, error) in
            self.actIndicator.isHidden = true
            self.actIndicator.stopAnimating()
            for view in self.loginView.subviews {
                if view.tag == 0 {
                    view.isHidden = false
                }
            }
            if let err = error as NSError? {
                guard let err = AuthErrorCode(rawValue: err.code) else {
                    self.errorLabel.text = "Unknown error logging in"
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        actIndicator.isHidden = true
        googleDelegate = GoogleDelegate(view: loginView, spinner: actIndicator)
        GIDSignIn.sharedInstance().delegate = googleDelegate
        GIDSignIn.sharedInstance().uiDelegate = self
        emailField.useUnderline()
        passwordField.useUnderline()
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
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
