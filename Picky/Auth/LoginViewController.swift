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
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var googleDelegate : GoogleDelegate!
    
    @IBOutlet var loginView: UIView!
    
    
    @IBAction func login(_ sender: UIButton) {
        guard let estring = emailField.text else {
            
            return
        }
        guard let pstring = passwordField.text else {
            
            return
        }
        actIndicator.isHidden = false
        actIndicator.startAnimating()
        for view in loginView.subviews {
            if view.tag == 0 {
                view.isHidden = true
            }
        }
        Auth.auth().signIn(withEmail: estring, password: pstring) { (user, error) in
            self.actIndicator.isHidden = true
            self.actIndicator.stopAnimating()
            for view in self.loginView.subviews {
                if view.tag == 0 {
                    view.isHidden = false
                }
            }
            if let err = error as NSError? {
                guard let err = AuthErrorCode(rawValue: err.code) else {
                    print("Unknown error logging in")
                    return
                }
                switch err {
                case .invalidEmail:
                    print("invalid email")
                default:
                    print("Firebase error you didn't handle")
                }
            } else {
                //login successful
            
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        actIndicator.isHidden = true
        googleDelegate = GoogleDelegate(view: loginView, spinner: actIndicator)
        GIDSignIn.sharedInstance().delegate = googleDelegate
        GIDSignIn.sharedInstance().uiDelegate = self
        emailField.useUnderline()
        passwordField.useUnderline()
    }
    
    
    func verifyEmail(emailString : String) -> Bool {
        return true
    }
    func verifyPassword(passwordString: String) -> Bool {
        return true
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
