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
    enum checkStatus: String {
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
    
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("login", forKey: "ProfileStatus")
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userNameTF.text = ""
        passwordTF.text = ""
        userNameChecker.text = checkStatus.none.rawValue
        passwordChecker.text = checkStatus.none.rawValue
        userNameTF.becomeFirstResponder()
        
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        //        self.title = "LOG IN"
        userNameTF.becomeFirstResponder()
        self.navigationItem.title = "Login"
        loginButton.roundedCornersWithBorder(cornerRadius: 4)
        loginButton.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        userNameTF.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        passwordTF.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        userNameChecker.roundedCornersWithBorder(cornerRadius: userNameChecker.frame.height/2)
        passwordChecker.roundedCornersWithBorder(cornerRadius: userNameChecker.frame.height/2)
        
        self.navigationController?.navigationBar.elevateView()
    }
    
    
    //  MARK: - IBActions
    @IBAction func userNameValidation() {
        if userNameTF.text!.isEmpty {
            userNameChecker.text = checkStatus.none.rawValue
        }
        else if true { //Implement regex here
            let validationURL = "https://qa.curiousworld.com/api/v3/Validate/Email?_format=json"
            let parameters = ["mail" : userNameTF.text!]
            
            NetworkManager.sharedInstance.profileApi(urlString: validationURL, parameters: parameters, completion: { (data, responseError) in
                
                if data != nil {
                    DispatchQueue.global().async {
                        let status = data as! ProfileModel
                        
                        DispatchQueue.main.async {
                            if status.Status.statusCode == 1 {
                                self.userNameChecker.textColor = UIColor.green
                                self.userNameChecker.text = checkStatus.correct.rawValue
                            }
                            else {
                                self.userNameChecker.textColor = UIColor.red
                                self.userNameChecker.text = checkStatus.incorrect.rawValue
                            }
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.userNameChecker.textColor = UIColor.blue
                        self.userNameChecker.text = checkStatus.unknown.rawValue
                        //                        self.showToast(controller: self, message: "Somwthing went wrong", seconds: 1.2)
                    }
                }
            })
        }
    }
    
    
    @IBAction func passwordValidation() {
        if passwordTF.text!.isEmpty {
            passwordChecker.textColor = UIColor.white
        }
        else if userNameChecker.text == checkStatus.unknown.rawValue {
            passwordChecker.textColor = UIColor.blue
            passwordChecker.text = checkStatus.unknown.rawValue
        }
        else if passwordTF.text!.count < 8 {
            passwordChecker.textColor = UIColor.red
            passwordChecker.text = checkStatus.incorrect.rawValue
        }
        else {
            passwordChecker.textColor = UIColor.green
            passwordChecker.text = checkStatus.correct.rawValue
        }
    }
    
    @IBAction func loginIn() {
        if !userNameTF.text!.isEmpty {
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
                    
                    DispatchQueue.main.async {
                        let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { action in self.loginIn() })) // Retry option to hit api in case internet didn't worked in first place
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                            self.userNameTF.text = ""
                            self.userNameChecker.text = checkStatus.none.rawValue
                            self.passwordTF.text = ""
                            self.passwordChecker.text = checkStatus.none.rawValue
                            self.userNameTF.becomeFirstResponder()
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                } else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let loginResponse = data as! LoginModel
                            DispatchQueue.main.async {
                                //add to child view later
                                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                                let controller = storyboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                                controller.profileData = loginResponse
                                self.navigationController?.pushViewController(controller, animated: false)
                                UserDefaults.standard.set(true, forKey: "isLoggenIn")
                            }
                        }
                    }
                    else {
                        //wrong email or password
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Alert", message: "Could not login", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            })
            
            
        }
        else {
            showToast(controller: self, message: "Empty username", seconds: 1.2)
        }
        
    }
    
    
    @IBAction func forgetPassword() {
        if userNameTF.text!.isEmpty || userNameChecker.text == checkStatus.incorrect.rawValue {
            showToast(controller: self, message: "First enter a valid mail", seconds: 1.2)
        }
        else if userNameChecker.text == checkStatus.correct.rawValue {
            let forgetURL = "https://qa.curiousworld.com/api/v3/ForgetPassword?_format=json"
            let parameters = ["mail" :  userNameTF.text!]
            
            NetworkManager.sharedInstance.profileApi(urlString: forgetURL, parameters: parameters, completion: { (data, responseError) in
                if let error = responseError {
                    DispatchQueue.global().async {
                        let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { action in self.loginIn() })) // Retry option to hit api in case internet didn't worked in first place
                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let forgetResponse = data as! ProfileModel
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Alert", message: forgetResponse.Status.message, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Alert", message: "Invalid email entered", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            })
        }
        else if userNameChecker.text == checkStatus.unknown.rawValue {
            showToast(controller: self, message: "Please check your connection", seconds: 1.2)
        }
    }
    
    
    @IBAction func signUp() {
        //add to child view later
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(controller, animated: false)
        
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
    
    
}


//  MARK: - Extensions
extension LoginController {
    
}
