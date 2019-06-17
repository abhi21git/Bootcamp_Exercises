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
        userNameChecker.text = ""
        passwordChecker.text = ""
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
            userNameChecker.textColor = UIColor.white
        }
        else {
            let validationURL = "https://qa.curiousworld.com/api/v3/Validate/Email?_format=json"
            let parameters = ["mail" : userNameTF.text!]
            
            NetworkManager.sharedInstance.profileApi(urlString: validationURL, parameters: parameters, completion: { (data, responseError) in
                
                if data != nil {
                    DispatchQueue.global().async {
                        let status = data as! ProfileModel
                        
                        DispatchQueue.main.async {
                            if status.Status.statusCode == 1 {
                                self.userNameChecker.textColor = UIColor.green
                                self.userNameChecker.text = "✓"
                            }
                            else {
                                self.userNameChecker.textColor = UIColor.red
                                self.userNameChecker.text = "✗"
                            }
                        }
                    }
                }
            })
        }
    }
    
    
    @IBAction func passwordValidation() {
        if passwordTF.text!.isEmpty {
            passwordChecker.textColor = UIColor.white
        }
        else if passwordTF.text!.count < 8 {
            passwordChecker.textColor = UIColor.red
            passwordChecker.text = "✗"
        }
        else {
            passwordChecker.textColor = UIColor.green
            passwordChecker.text = "✓"
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
                    
                    print(error.localizedDescription)
                    let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.loginIn() })) // Retry option to hit api in case internet didn't worked in first place
                    self.present(alert, animated: true, completion: nil)
                    
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
    
    @IBAction func signUp() {
        //add to child view later
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    
    @IBAction func forgetPassword() {
        let forgetURL = "https://qa.curiousworld.com/api/v3/ForgetPassword?_format=json"
        let parameters = ["mail" :  userNameTF.text!]
        
        NetworkManager.sharedInstance.profileApi(urlString: forgetURL, parameters: parameters, completion: { (data, responseError) in
            if let error = responseError {
                
                let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.loginIn() })) // Retry option to hit api in case internet didn't worked in first place
                self.present(alert, animated: true, completion: nil)
                
            } else {
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
