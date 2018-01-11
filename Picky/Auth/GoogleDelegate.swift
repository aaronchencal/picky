//
//  GoogleDelegate.swift
//  Picky
//
//  Created by Aaron Chen on 12/29/17.
//  Copyright © 2017 ACDev. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class GoogleDelegate : NSObject, GIDSignInDelegate {
    
    
    private var parentView: UIView!
    private var spinner: UIActivityIndicatorView!
    
    init(view: UIView, spinner: UIActivityIndicatorView) {
        super.init()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        parentView = view
        self.spinner = spinner
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        spinner.isHidden = false
        spinner.startAnimating()
        for view in parentView.subviews {
            if view.tag == 0 {
                view.isHidden = true
            }
        }
        
        if let error = error {
            self.stopSpinner()
            return
        }

        guard let authentication = user.authentication else {
            self.stopSpinner()
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, errors) in
            self.stopSpinner()
            if let error = error {
                // ...
                return
            }
            print("signed in")
        }
        
    }
    
    func stopSpinner() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        for view in self.parentView.subviews {
            if view.tag == 0 {
                view.isHidden = false
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        ///
    }
    
    
    
}

