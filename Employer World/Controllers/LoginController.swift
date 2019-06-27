//
//  LoginController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class LoginController: UIViewController, Toastable {
    
    //  MARK: - Variables
    enum CheckStatus: String {
        case correct = "✓"
        case incorrect = "✗"
        case unknown = "?"
        case none = ""
    }
    
    
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
        self.navigationItem.title = "Login"
        loginButton.roundedCornersWithBorder(cornerRadius: 4)
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        loader.isHidden = true
        loginButton.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        userNameTF.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        passwordTF.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        userNameChecker.roundedCornersWithBorder(cornerRadius: userNameChecker.frame.height/2)
        passwordChecker.roundedCornersWithBorder(cornerRadius: userNameChecker.frame.height/2)
        userNameTF.returnKeyType = UIReturnKeyType.next
        passwordTF.returnKeyType = UIReturnKeyType.done
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        if UserDefaults.standard.string(forKey: "ProfileStatus") == "signup" {
            signUp()
        }
        else if UserDefaults.standard.string(forKey: "ProfileStatus") == "profile" {
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
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: testStr)
    }
    
    func isValidPassword(testStr:String) -> Bool {
        let passwordRegEx = "(?=.*[a-zA-Z])(?=.*[0-9]).{8,64}$"
        return NSPredicate(format:"SELF MATCHES %@", passwordRegEx).evaluate(with: testStr)
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
                let validationURL = "https://qa.curiousworld.com/api/v3/Validate/Email?_format=json"
                let parameters = ["mail" : userNameTF.text!]
                
                NetworkManager.sharedInstance.profileApi(urlString: validationURL, parameters: parameters, completion: { (data, responseError) in
                    if responseError != nil {
                        DispatchQueue.main.async {
                            self.userNameChecker.textColor = UIColor.blue
                            self.userNameChecker.text = CheckStatus.unknown.rawValue
                        }
                    }
                    
                    if data != nil {
                        DispatchQueue.global().async {
                            let status = data as! ProfileModel
                            
                            DispatchQueue.main.async {
                                if status.Status.statusCode == 1 {
                                    self.userNameChecker.textColor = UIColor.green
                                    self.userNameChecker.text = CheckStatus.correct.rawValue
                                }
                            }
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
    
    @IBAction func loginIn() {
        if userNameChecker.text == CheckStatus.correct.rawValue {
            
            loader.isHidden = false
            
            let loginURL = "https://qa.curiousworld.com/api/v3/Login?_format=json"
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
            
            NetworkManager.sharedInstance.logIn(urlString: loginURL, parameters: parametersData, completion: { (data, responseError) in
                if let error = responseError {
                    self.showToast(controller: self, message: error.localizedDescription)
                    DispatchQueue.main.async {
                        self.userNameChecker.text = CheckStatus.unknown.rawValue
                        self.passwordChecker.text = CheckStatus.unknown.rawValue
                    }
                    
                } else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let loginResponse = data as! LoginModel
                            DispatchQueue.main.async {
                                //add to child view later
                                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                                let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                                profileVC.profileData = loginResponse
                                self.addChild(profileVC)
                                self.view.addSubview(profileVC.view)
                                profileVC.didMove(toParent: self)
                                
                                self.loader.isHidden = true
                                self.userNameTF.text = ""
                                self.passwordTF.text = ""
                                self.userNameChecker.text = CheckStatus.none.rawValue
                                self.passwordChecker.text = CheckStatus.none.rawValue                                
                            }
                        }
                    }
                    else {
                        self.showToast(controller: self, message: "Cannot Login")
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
        if userNameTF.text!.isEmpty || userNameChecker.text == CheckStatus.incorrect.rawValue {
            showToast(controller: self, message: "First enter a valid mail")
        }
        else if userNameChecker.text == CheckStatus.correct.rawValue {
            let forgetURL = "https://qa.curiousworld.com/api/v3/ForgetPassword?_format=json"
            let parameters = ["mail" :  userNameTF.text!]
            
            NetworkManager.sharedInstance.profileApi(urlString: forgetURL, parameters: parameters, completion: { (data, responseError) in
                if let error = responseError {
                    DispatchQueue.global().async {
                        self.showToast(controller: self, message: error.localizedDescription)
                    }
                }
                else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let forgetResponse = data as! ProfileModel
                            self.showToast(controller: self, message: forgetResponse.Status.message!, seconds: 2)
                        }
                    }
                    else {
                        self.showToast(controller: self, message: "Invalid email entered", seconds: 1.2)
                    }
                }
            })
        }
        else if userNameChecker.text == CheckStatus.unknown.rawValue {
            showToast(controller: self, message: "Please check your connection")
        }
    }
    
    
    @IBAction func signUp() {
        //add to child view later
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let signupVC = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        
        addChild(signupVC)
        self.view.addSubview(signupVC.view)
        signupVC.didMove(toParent: self)
        
        UserDefaults.standard.set("signup", forKey: "ProfileStatus")
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
