//
//  LoginController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UserDataValidation, Toastable {
    
    //  MARK: - Variables
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameChecker: UILabel!
    @IBOutlet weak var passwordChecker: UILabel!
    @IBOutlet weak var forgetButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        userNameTF.becomeFirstResponder()
        self.navigationItem.title = LOGINTITLE
//        navigationController?.navigationBar.addBlurEffect()
        loader.isHidden = true
        loginButton.roundedCornersWithBorder(cornerRadius: 4)
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        userNameChecker.roundedCornersWithBorder(cornerRadius: userNameChecker.frame.height/2)
        passwordChecker.roundedCornersWithBorder(cornerRadius: userNameChecker.frame.height/2)
        loginButton.elevateView(shadowOffset: SHADOWOFFSET)
        userNameTF.elevateView(shadowOffset: SHADOWOFFSET)
        passwordTF.elevateView(shadowOffset: SHADOWOFFSET)
        userNameTF.returnKeyType = UIReturnKeyType.next
        passwordTF.returnKeyType = UIReturnKeyType.done
        
        if UserDefault.string(forKey: PROFILESTATUS) == PROFILESTATUSSIGNUP {
            signUp()
        }
        else if UserDefault.string(forKey: PROFILESTATUS) == PROFILESTATUSPROFILE {
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            let profileVC = storyBoard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
            
            addChild(profileVC)
            self.view.addSubview(profileVC.view)
            profileVC.didMove(toParent: self)
        }
    }
    
    func getPostDataAttributes(params:[String:String]) -> Data {
        var data = Data()
        for(key, value) in params {
            let string = "--CuriousWorld\r\n".data(using: .utf8)
            data.append(string!)
            data.append(String.init(format: "Content-Disposition: form-data; name=%@\r\n\r\n", key).data(using: .utf8)!)
            data.append(String.init(format: "%@\r\n", value).data(using: .utf8)!)
            data.append(String.init(format: "--CuriousWorld--\r\n").data(using: .utf8)!)
        }
        return data
    }
    
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
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
                let parameters = ["mail" : userNameTF.text!]
                
                NetworkManager.sharedInstance.profileApi(urlString: EMAILVALIDATIONURL, parameters: parameters, completion: { result in
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
    
    
    @IBAction func passwordValidation() {
        if passwordTF.text!.isEmpty {
            passwordChecker.text = CheckStatus.none.rawValue
        }
        else if userNameChecker.text == CheckStatus.unknown.rawValue {
            passwordChecker.textColor = UIColor.blue
            passwordChecker.text = CheckStatus.unknown.rawValue
        }
        else if isValidPassword(testStr: passwordTF.text!){
            passwordChecker.textColor = UIColor.green
            passwordChecker.text = CheckStatus.correct.rawValue
        }
        else {
            passwordChecker.textColor = UIColor.red
            passwordChecker.text = CheckStatus.incorrect.rawValue
        }
    }
    
    @IBAction func removeCheck() {
        if userNameTF.text!.isEmpty {
            userNameChecker.text = CheckStatus.none.rawValue
        }
        if passwordTF.text!.isEmpty {
            passwordChecker.text = CheckStatus.none.rawValue
        }
    }
    
    @IBAction func loginIn() {
        if userNameChecker.text == CheckStatus.correct.rawValue {
            
            loader.isHidden = false
            
            let loginParam = [
                "mail" : userNameTF.text! ,
                "password" : passwordTF.text!,
                "deviceId" : "12345",
                "client_secret" : "abcde12345",
                "client_id" : "ec7c3bde-9f51-4113-9ecf-6ca6fd03b66b",
                "scope" : "ios",
                "grant_type" : "password"
            ]
            
            let parametersData = getPostDataAttributes(params: loginParam)
            
            NetworkManager.sharedInstance.logIn(urlString: LOGINURL, parameters: parametersData, completion: { result in
                switch result {
                case .success(let data):
                    DispatchQueue.global().async {
                        let loginResponse = data as! LoginModel
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                            profileVC.profileData = loginResponse
                            self.addChild(profileVC)
                            self.view.addSubview(profileVC.view)
                            profileVC.didMove(toParent: self)
                            
                            self.loader.isHidden = true
                            self.userNameTF.text = BLANKSTRING
                            self.passwordTF.text = BLANKSTRING
                            self.userNameChecker.text = CheckStatus.none.rawValue
                            self.passwordChecker.text = CheckStatus.none.rawValue
                        }
                    }
                case .failure(let error):
                    self.showToast(controller: self, message: error.localizedDescription)
                    DispatchQueue.main.async {
                        self.userNameChecker.text = CheckStatus.unknown.rawValue
                        self.passwordChecker.text = CheckStatus.unknown.rawValue
                    }
                }
            })
        }
        else if userNameChecker.text == CheckStatus.incorrect.rawValue || passwordChecker.text == CheckStatus.incorrect.rawValue {
            showToast(controller: self, message: "Wrong username or password")
        }
        else if userNameChecker.text == CheckStatus.unknown.rawValue {
            showToast(controller: self, message: "Login failed, check internet.")
        }
        else if userNameChecker.text == CheckStatus.none.rawValue || passwordChecker.text == CheckStatus.none.rawValue {
            showToast(controller: self, message: "Enter username and password")
        }
    }
    
    
    @IBAction func forgetPassword() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let resetVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordController") as! ResetPasswordController

        addChild(resetVC)
        self.view.addSubview(resetVC.view)
        resetVC.didMove(toParent: self)
        
//        let alert = UIAlertController(title: "Reset Password", message: "To reset your password please enter your email address.", preferredStyle: UIAlertController.Style.alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Enter email address"
//        }
//        alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: {action in
//            self.loader.isHidden = false
//
//            let parameters = ["mail" :  alert.textFields![0].text!]
//
//            NetworkManager.sharedInstance.profileApi(urlString: FORGOTEMAILURL, parameters: parameters, completion: { result in
//                switch result {
//                case .success(let data):
//                    DispatchQueue.global().async {
//                        let forgetResponse = data as! ProfileModel
//                        DispatchQueue.main.async {
//                            self.loader.isHidden = true
//                            self.showToast(controller: self, message: forgetResponse.Status.message!, seconds: 2)
//                        }
//                    }
//                case .failure(let error):
//                    DispatchQueue.main.async {
//                        self.loader.isHidden = true
//                        self.showToast(controller: self, message: error.localizedDescription)
//                    }
//                }
//            })
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func signUp() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let signupVC = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        
        addChild(signupVC)
        self.view.addSubview(signupVC.view)
        signupVC.didMove(toParent: self)
        
        UserDefault.set(PROFILESTATUSSIGNUP, forKey: PROFILESTATUS)
    }
    
    
}


//  MARK: - Extensions
extension LoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            userNameTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        }
        else if textField == passwordTF {
            passwordTF.resignFirstResponder()
        }
        return true
    }
    
}
