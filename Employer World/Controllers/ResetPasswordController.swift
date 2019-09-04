//
//  ForgotPassword.swift
//  Employer World
//
//  Created by Abhishek Maurya on 28/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ResetPasswordController: UIViewController, UserDataValidation, Toastable {
    
    //  MARK: - Variables

    
    //  MARK: - IBOutlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var userNameChecker: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        userNameTF.becomeFirstResponder()
        self.navigationController?.navigationBar.topItem?.title = RESETPASSWORDTITLE
        resetButton.roundedCornersWithBorder(cornerRadius: THEMECORNERRADIUS)
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        loader.isHidden = true
        resetButton.elevateView(shadowOffset: SHADOWOFFSET)
        userNameTF.elevateView(shadowOffset: SHADOWOFFSET)
        userNameChecker.roundedCornersWithBorder(cornerRadius: userNameChecker.frame.height/2)
        userNameTF.returnKeyType = UIReturnKeyType.done
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTF.resignFirstResponder()
        view.endEditing(true)
    }
    
    
    //  MARK: - IBActions
    @IBAction func userNameValidation() {
        if userNameTF.text!.isEmpty {
            userNameChecker.text = CheckStatus.none.rawValue
        }
        else if userNameTF.text != nil {
            self.userNameChecker.textColor = UIColor.red
            self.userNameChecker.text = CheckStatus.incorrect.rawValue
            
            if isValidEmail(testStr: userNameTF.text!) {
                let validationURL = "https://qa.curiousworld.com/api/v3/Validate/Email?_format=json"
                let parameters = ["mail" : userNameTF.text!]
                
                NetworkManager.sharedInstance.profileApi(urlString: validationURL, parameters: parameters, completion: { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.global().async {
                            let status = data as! ProfileModel
                            
                            DispatchQueue.main.async {
                                if status.Status.statusCode == 1 {
                                    self.userNameChecker.textColor = UIColor.green
                                    self.userNameChecker.text = CheckStatus.correct.rawValue
                                }
                            }
                        }
                    case .failure( _):
                        DispatchQueue.main.async {
                            self.userNameChecker.textColor = UIColor.blue
                            self.userNameChecker.text = CheckStatus.unknown.rawValue
                        }
                    }
                })
            }
        }
    }
    
    
    @IBAction func forgetPassword() {
        if userNameTF.text!.isEmpty || userNameChecker.text == CheckStatus.incorrect.rawValue {
            showToast(controller: self, message: "First enter a valid mail")
        }
        else if userNameChecker.text == CheckStatus.correct.rawValue {
            let forgetURL = "https://qa.curiousworld.com/api/v3/ForgetPassword?_format=json"
            let parameters = ["mail" :  userNameTF.text!]
            
            NetworkManager.sharedInstance.profileApi(urlString: forgetURL, parameters: parameters, completion: { result in
                switch result {
                case .success(let data):
                    DispatchQueue.global().async {
                        let forgetResponse = data as! ProfileModel
                        self.showToast(controller: self, message: forgetResponse.Status.message!, seconds: 2)
                        DispatchQueue.main.async {
                            self.resetPassword()
                        }
                    }
                case .failure(let error):
                    DispatchQueue.global().async {
                        self.showToast(controller: self, message: error.localizedDescription)
                    }
                }
            })
        }
        else if userNameChecker.text == CheckStatus.unknown.rawValue {
            showToast(controller: self, message: "Please check your connection")
        }
    }
    
    
    @IBAction func resetPassword() {
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
            self.navigationController?.navigationBar.topItem?.title = "Login"
    }
    
}


//  MARK: - Extensions
extension ResetPasswordController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            userNameTF.resignFirstResponder()
        }
        return true
    }
    
}
