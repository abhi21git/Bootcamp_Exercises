//
//  LoginController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    //  MARK: - Variables
    
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userNameChecker: UILabel!
    @IBOutlet weak var passwordChecker: UILabel!
    @IBOutlet weak var forgetButton: UIButton!
    
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userNameTextField.text = ""
        passwordTextField.text = ""
        userNameChecker.text = ""
        passwordChecker.text = ""
        userNameTextField.becomeFirstResponder()
        UserDefaults.standard.set("login", forKey: "ProfileStatus")
    
    }
    
    
    //  MARK: - Functions
    func configureUI() {
//        self.title = "LOG IN"
        userNameTextField.becomeFirstResponder()
        self.navigationItem.title = "Login"
        loginButton.roundedCornersWithBorder(cornerRadius: 4)
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        
    }
    
    
    //  MARK: - IBActions
    @IBAction func userNameValidation() {
        if !userNameTextField.text!.isEmpty {
            let userName = userNameTextField.text!
            let validationURL = "https://qa.curiousworld.com/api/v3/Validate/Email?_format=json"
            
            NetworkManager.sharedInstance.emailValidationAndForget(urlString: validationURL, userID: userName, completion: { (data, responseError) in
                if let error = responseError {
                    
                    let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.loginIn() })) // Retry option to hit api in case internet didn't worked in first place
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let status = data as! ValidationData
                            
                            DispatchQueue.main.async {
                                if status.uStatus.statusCode == 1 {
                                    self.userNameChecker.text = "✓"
                                }
                                else {
                                    self.userNameChecker.text = "✗"
                                }
                            }
                        }
                    }
                }
            })
        }
    }
    
    @IBAction func passwordValidation() {
        if passwordTextField.text!.count < 8 {
            passwordChecker.text = "✗"
        }
        else {
            passwordChecker.text = "✓"
        }
    }
    
    @IBAction func loginIn() {
        if !userNameTextField.text!.isEmpty {
            let userName = userNameTextField.text!
            let password = passwordTextField.text!
            let loginURL = "https://qa.curiousworld.com/api/v3/Login?_format=json"
            
            NetworkManager.sharedInstance.logIn(urlString: loginURL, userID: userName, password: password, completion: { (data, responseError) in
                if let error = responseError {
                    
                    print(error.localizedDescription)
                    let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.loginIn() })) // Retry option to hit api in case internet didn't worked in first place
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let loginResponse = data as! LoginData
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
                            let alertController = UIAlertController(title: "Alert", message: "Invalid email or password", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            })
            
            
        }
        else {
            //show toast here for empty username
        }
        
    }
    
    @IBAction func signUp() {
        //add to child view later
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(controller, animated: false)
        
    }
    
    @IBAction func forgetPassword() {
        let userName = userNameTextField.text!
        let forgetURL = "https://qa.curiousworld.com/api/v3/ForgetPassword?_format=json"
        
        NetworkManager.sharedInstance.emailValidationAndForget(urlString: forgetURL, userID: userName, completion: { (data, responseError) in
            if let error = responseError {
                
                let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.loginIn() })) // Retry option to hit api in case internet didn't worked in first place
                self.present(alert, animated: true, completion: nil)
                
            } else {
                if data != nil {
                    DispatchQueue.global().async {
                        let forgetResponse = data as! ValidationData
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Alert", message: forgetResponse.uStatus.message, preferredStyle: .alert)
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
    
    
}


//  MARK: - Extensions
extension LoginController {
    
}
