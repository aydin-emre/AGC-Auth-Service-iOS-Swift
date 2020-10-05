//
//  TwitterAccountViewController.swift
//  Auth Service
//
//  Created by Emre AYDIN on 10/2/20.
//

import UIKit
import AGConnectAuth
import SafariServices
import Swifter

class TwitterAccountViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signOutButton: UIButton!
    
    var swifter: Swifter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setSignInOutVisibility()
    }

    @IBAction func signInButton(_ sender: UIButton) {
        self.swifter = Swifter(consumerKey: TWITTER_API_KEY, consumerSecret: TWITTER_API_SECRET_KEY)
        self.swifter.authorize(withCallback: URL(string: TWITTER_URL_SCHEME)!, presentingFrom: self, success: { accessToken, _ in
            self.signIn(with: accessToken)
        }, failure: { error in
            print("ERROR: Trying to authorize \(error)")
        })
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        AGCAuth().signOut()
        setSignInOutVisibility()
    }
    
    func signIn(with accessToken: Credential.OAuthAccessToken?) {
        if let accessToken = accessToken {
            let credential = AGCTwitterAuthProvider.credential(withToken: accessToken.key, secret: accessToken.secret)
            
            AGCAuth().signIn(credential: credential).onSuccess { (agcSignInResult) in
                if let username = accessToken.screenName {
                    self.showAlert(with: "You are logged in: \(username)")
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
            titleLabel.text = "Signed in: \(user.uid)"
            signInButton.isHidden = true
            signOutButton.isHidden = false
        } else {
            titleLabel.text = "Sign in with Twitter"
            signInButton.isHidden = false
            signOutButton.isHidden = true
        }
    }

}

extension TwitterAccountViewController: SFSafariViewControllerDelegate {}
