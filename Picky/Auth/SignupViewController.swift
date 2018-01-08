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
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    private var googleDelegate : GoogleDelegate!
    
    @IBAction func signup(_ sender: UIButton) {
        guard let estring = emailField.text else {
            
            return
        }
        guard let pstring = passwordField.text else {
            
            return
        }
        
        Auth.auth().createUser(withEmail: estring, password: pstring) { (user, error) in
            if let err = error as NSError? {
                guard let err = AuthErrorCode(rawValue: err.code) else {
                    print("Unknown error")
                    return
                }
                switch err {
                case .invalidEmail:
                    print("invalid email")
                default:
                    print("Firebase error you didn't handle: \(error!.localizedDescription)")
                }
            } else {
                //login successful
            }
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
        googleDelegate = GoogleDelegate(parentController: self, id: "signuptofilter")
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

