//
//  PhoneNumberViewController.swift
//  Auth Service
//
//  Created by Emre AYDIN on 9/28/20.
//

import UIKit
import AGConnectAuth

class PhoneNumberViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var phoneNumberStackView: UIStackView!
    @IBOutlet var verificationStackView: UIStackView!
    @IBOutlet var geoCodeTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var verificationCodeTextField: UITextField!
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
        if let geoCode = geoCodeTextField.text, let phoneNumber = phoneNumberTextField.text {
            if geoCode.isEmpty {
                showAlert(with: "Enter geo code!")
            } else if phoneNumber.isEmpty {
                showAlert(with: "Enter your phone number!")
            } else {
                AGCPhoneAuthProvider.requestVerifyCode(withCountryCode: geoCode, phoneNumber: phoneNumber, settings: settings).onSuccess { (agcVerifyCodeResult) in
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
        if let geoCode = geoCodeTextField.text, let phoneNumber = phoneNumberTextField.text, let verificationCode = verificationCodeTextField.text {
            if geoCode.isEmpty {
                showAlert(with: "Enter geo code!")
            } else if phoneNumber.isEmpty {
                showAlert(with: "Enter your phone number!")
            } else if verificationCode.isEmpty {
                showAlert(with: "Enter verify code!")
            } else {
                AGCAuth().createUser(withCountryCode: geoCode, phoneNumber: phoneNumber, password: nil, verifyCode: verificationCode).onSuccess { (result) in
                    // onSuccess
                    if let result = result {
                        let user = result.user
                        self.showAlert(with: "You are registered: \(user.phone!)")
                        self.setSignInOutVisibility()
                    }
                }.onFailure { (error) in
                    // onFail
                    print("******* Error: \(error)")
                    if error.code == 203818130 {
                        self.login(with: geoCode, phoneNumber, verificationCode)
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
    
    func login(with geoCode: String, _ phoneNumber: String, _ verificationCode: String) {
        let credential = AGCPhoneAuthProvider.credential(withCountryCode: geoCode, phoneNumber: phoneNumber, password: nil, verifyCode: verificationCode)

        AGCAuth().signIn(credential: credential).onSuccess { (agcSignInResult) in
            if let result = agcSignInResult {
                let user = result.user
                self.showAlert(with: "You are logged in: \(user.phone!)")
                self.setSignInOutVisibility()
            }
        }.onFailure { (error) in
            print("******* Error: \(error)")
            self.showAlert(with: error.localizedDescription)
        }
    }
    
    func setSignInOutVisibility() {
        if let user = AGCAuth().currentUser {
            if let phoneNumber = user.phone {
                titleLabel.text = "Signed in: \(phoneNumber)"
            }
            phoneNumberStackView.isHidden = true
            verificationStackView.isHidden = true
            signInButton.isHidden = true
            signOutButton.isHidden = false
        } else {
            titleLabel.text = "Login/Register with Phone Number"
            phoneNumberStackView.isHidden = false
            verificationStackView.isHidden = false
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
