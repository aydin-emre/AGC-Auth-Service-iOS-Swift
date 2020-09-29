//
//  EmailViewController.swift
//  Auth Service
//
//  Created by Emre AYDIN on 9/29/20.
//

import UIKit
import AGConnectAuth

class EmailViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var verificationStackView: UIStackView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var verificationCodeTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var obtainCodeButton: UIButton!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var signOutButton: UIButton!
    
    var countdownTimer: Timer!
    var totalTime = 30
    
    var settings: AGCVerifyCodeSettings!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        settings = AGCVerifyCodeSettings(action: .registerLogin, locale: nil, sendInterval: 30)
        
        setSignInOutVisibility()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if countdownTimer != nil {
            countdownTimer.invalidate()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func obtainCodeButton(_ sender: UIButton) {
        if let email = emailTextField.text {
            if email.isEmpty {
                showAlert(with: "Enter your email!")
            } else {
                AGCEmailAuthProvider.requestVerifyCode(withEmail: email, settings: settings).onSuccess { (agcVerifyCodeResult) in
                    // The verification code application is successful.
                    print("******* Success: \(agcVerifyCodeResult)")
                    
                    self.totalTime = 30
                    self.obtainCodeButton.isUserInteractionEnabled = false
                    self.obtainCodeButton.setTitleColor(.gray, for: .normal)
                    self.countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
                }.onFailure { (error) in
                    // The verification code application fails.
                    print("******* Error: \(error)")
                    self.showAlert(with: error.localizedDescription)
                }
            }
        }
    }

    @IBAction func signInButton(_ sender: UIButton) {
        if let email = emailTextField.text, let verificationCode = verificationCodeTextField.text {
            if email.isEmpty {
                showAlert(with: "Enter your email!")
            } else if verificationCode.isEmpty {
                showAlert(with: "Enter verify code!")
            } else {
                AGCAuth().createUser(withEmail: email, password: nil, verifyCode: verificationCode).onSuccess { (result) in
                    // onSuccess
                    if let result = result {
                        let user = result.user
                        self.showAlert(with: "You are registered: \(user.email!)")
                        self.setSignInOutVisibility()
                    }
                }.onFailure { (error) in
                    // onFail
                    print("******* Error: \(error)")
                    if error.code == 203818130 {
                        self.login(with: email, verificationCode)
                    } else {
                        self.showAlert(with: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @IBAction func signOutButton(_ sender: UIButton) {
        AGCAuth().signOut()
        setSignInOutVisibility()
    }
    
    func login(with email: String, _ verificationCode: String) {
        let credential = AGCEmailAuthProvider.credential(withEmail: email, password: nil, verifyCode: verificationCode)

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
    
    func setSignInOutVisibility() {
        if let user = AGCAuth().currentUser {
            if let email = user.email {
                titleLabel.text = "Signed in: \(email)"
            }
            verificationStackView.isHidden = true
            emailTextField.isHidden = true
            signInButton.isHidden = true
            signOutButton.isHidden = false
        } else {
            titleLabel.text = "Login/Register with Email"
            verificationStackView.isHidden = false
            emailTextField.isHidden = false
            signInButton.isHidden = false
            signOutButton.isHidden = true
        }
    }
    
    @objc func updateTime() {
        UIView.performWithoutAnimation {
            obtainCodeButton.setTitle(timeFormatted(totalTime), for: .normal)
            obtainCodeButton.layoutIfNeeded()
        }
        
        if totalTime == 0 {
            endTimer()
        }
        
        totalTime -= 1
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        obtainCodeButton.setTitle("Obtain Code", for: .normal)
        obtainCodeButton.isUserInteractionEnabled = true
        obtainCodeButton.setTitleColor(.systemBlue, for: .normal)
    }

}
