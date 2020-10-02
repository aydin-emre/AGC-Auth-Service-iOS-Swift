//
//  GoogleAccountViewController.swift
//  Auth Service
//
//  Created by Emre AYDIN on 9/30/20.
//

import UIKit
import AGConnectAuth
import GoogleSignIn

class GoogleAccountViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        GIDSignIn.sharedInstance().presentingViewController = self
        
        GIDSignIn.sharedInstance().delegate = self
        
        // Automatically sign in the user.
//        GIDSignIn.sharedInstance().restorePreviousSignIn()
        
        setSignInOutVisibility()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    @IBAction func signOutButton(_ sender: UIButton) {
        AGCAuth().signOut()
        setSignInOutVisibility()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        if let idToken = user.authentication.idToken {
            let credential = AGCGoogleAuthProvider.credential(withToken: idToken)
            
            AGCAuth().signIn(credential: credential).onSuccess { (agcSignInResult) in
                if let result = agcSignInResult {
                    let user = result.user
                    self.showAlert(with: "You are logged in: \(user.email!)")
                    self.setSignInOutVisibility()
                }
            }.onFailure { (error) in
                print("******* Error: \(error)")
                self.showAlert(with: error.localizedDescription)
            }
        }
    }
    
    func setSignInOutVisibility() {
        if let user = AGCAuth().currentUser {
            if let email = user.email {
                titleLabel.text = "Signed in: \(email)"
            }
            signInButton.isHidden = true
            signOutButton.isHidden = false
        } else {
            titleLabel.text = "Sign in with Google"
            signInButton.isHidden = false
            signOutButton.isHidden = true
        }
    }
    
}
