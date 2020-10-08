//
//  FacebookAccountViewController.swift
//  Auth Service
//
//  Created by Emre AYDIN on 10/5/20.
//

import UIKit
import AGConnectAuth
import FBSDKLoginKit

class FacebookAccountViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setSignInOutVisibility()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        LoginManager().logIn(permissions: ["email"], from: self) { (loginManagerLoginResult, error) in
            if let accessToken = loginManagerLoginResult?.token {
                let credential = AGCFacebookAuthProvider.credential(withToken: accessToken.tokenString)

                AGCAuth().signIn(credential: credential).onSuccess { (agcSignInResult) in
                    
                    self.showAlert(with: "You are logged in: \(accessToken.userID)")
                    self.setSignInOutVisibility()
                    
                }.onFailure { (error) in
                    print("******* Error: \(error)")
                    self.showAlert(with: error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        AGCAuth().signOut()
        setSignInOutVisibility()
    }
    
    func setSignInOutVisibility() {
        if let user = AGCAuth().currentUser {
            titleLabel.text = "Signed in: \(user.uid)"
            signInButton.isHidden = true
            signOutButton.isHidden = false
        } else {
            titleLabel.text = "Sign in with Facebook"
            signInButton.isHidden = false
            signOutButton.isHidden = true
        }
    }

}
