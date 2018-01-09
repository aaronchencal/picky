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
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private var googleDelegate : GoogleDelegate!
    
    @IBAction func login(_ sender: UIButton) {
        guard let estring = emailField.text else {
            
            return
        }
        guard let pstring = passwordField.text else {
            
            return
        }
        Auth.auth().signIn(withEmail: estring, password: pstring) { (user, error) in
            if let err = error as NSError? {
                guard let err = AuthErrorCode(rawValue: err.code) else {
                    print("Unkown error logging in")
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
        googleDelegate = GoogleDelegate()
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
