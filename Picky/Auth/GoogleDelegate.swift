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
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
            // ...
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, errors) in
            if let error = error {
                // ...
                return
            }
            print("signed in")
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        ///
    }
    
    
    
}

