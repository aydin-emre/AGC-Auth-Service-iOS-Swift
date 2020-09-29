//
//  ViewController.swift
//  Auth Service
//
//  Created by Emre AYDIN on 9/28/20.
//

import UIKit
import AGConnectAuth

class ViewController: UIViewController {
    
    var currentUser = AGCUser()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let settings = AGCVerifyCodeSettings(action: .registerLogin, locale: nil, sendInterval: 30)
//        
//        let credential = AGCPhoneAuthProvider.credential(withCountryCode: "90", phoneNumber: "5393596373", password: "emre123")
        
//        let credential = AGCPhoneAuthProvider.credential(withCountryCode: "90", phoneNumber: "5393596373", password: "", verifyCode: "504548")
//
//        AGCAuth().signIn(credential: credential).onSuccess { (agcSignInResult) in
//            print("******* agcSignInResult: \(agcSignInResult)")
//        }.onFailure { (error) in
//            print("******* Error: \(error)")
//        }

        print("******* phone: \(AGCAuth().currentUser?.phone)")
        
//        AGCAuth().signOut()
        
//        AGCAuth().deleteUser()
        
//        
//        
//        
//        
//        
//        
//        let settings = AGCVerifyCodeSettings(action: .registerLogin, locale: nil, sendInterval: 30)
//        
//        let ea = AGCEmailAuthProvider.requestVerifyCode(withEmail: "ea@ea.tc", settings: settings).onSuccess { (agcVerifyCodeResult) in
//            
//        }.onFailure { (error) in
//            
//        }
        
        
    }

}
