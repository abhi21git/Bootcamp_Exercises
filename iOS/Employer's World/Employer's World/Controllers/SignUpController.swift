//
//  SignUpController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, Toastable {
    
    //  MARK: - Variables
    var passwordMatched = false
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailChecker: UILabel!
    @IBOutlet weak var passwordChecker: UILabel!
    @IBOutlet weak var samePasswordChecker: UILabel!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("signup", forKey: "ProfileStatus")
        
        configureUI()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        //        self.title = "SIGN UP"
        //        self.tabBarController?.title = "SIGN UP"
        firstNameTF.becomeFirstResponder()
        self.navigationItem.title = "Signup"
        self.navigationItem.hidesBackButton = true
        for each in [firstNameTF, lastNameTF, emailTF, passwordTF, confirmPasswordTF] {
            each?.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        }
        signupButton.roundedCornersWithBorder(cornerRadius: 4)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //  MARK: - IBActions
    @IBAction func login() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func emailValidation() {
        let validationURL = "https://qa.curiousworld.com/api/v3/Validate/Email?_format=json"
        let parameters = ["mail" : emailTF.text!]
        
        NetworkManager.sharedInstance.profileApi(urlString: validationURL, parameters: parameters, completion: { (data, responseError) in
            
            if data != nil {
                DispatchQueue.global().async {
                    let status = data as! ProfileModel
                    DispatchQueue.main.async {
                        if status.Status.statusCode == 1 {
                            self.emailChecker.textColor = UIColor.red
                            self.emailChecker.text = "!"
                            self.showToast(controller: self, message: "Email ID already in use", seconds: 1.2)                        }
                        else {
                            self.emailChecker.text = ""
                        }
                    }
                }
            }
        })
    }
    
    
    @IBAction func passwordValidation() {
        if passwordTF.text!.isEmpty {
            passwordChecker.text = ""
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
    
    @IBAction func passwordMatching() {
        if confirmPasswordTF.text!.isEmpty{
            samePasswordChecker.text = ""
        }
        else if (passwordTF.text == confirmPasswordTF.text){
            samePasswordChecker.textColor = UIColor.green
            samePasswordChecker.text = "✓"
            passwordMatched = true
        }
        else {
            samePasswordChecker.textColor = UIColor.red
            samePasswordChecker.text = "✗"
            passwordMatched = false
        }
    }
    
    @IBAction func signUp() {
        if passwordMatched {
            let signpURL = "https://qa.curiousworld.com/api/v3/SignUp"
            let parameters = [
                "firstName" : firstNameTF.text ?? "",
                "lastName" : lastNameTF.text ?? "",
                "mail" : emailTF.text ?? "",
                "password" : passwordTF.text ?? ""
            ]
            
            NetworkManager.sharedInstance.profileApi(urlString: signpURL, parameters: parameters) { (data, responseError) in
                if let error = responseError {
                    self.showToast(controller: self, message: error.localizedDescription, seconds: 1.2)
                    
                } else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let signupResponse = data as! ProfileModel
                            DispatchQueue.main.async {
                                let alert  = UIAlertController(title: "Alert", message: signupResponse.Status.message, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                                    if signupResponse.Status.statusCode == 1 {
                                        self.login()
                                    }
                                }))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.showToast(controller: self, message: "Invalid response!", seconds: 1.2)
                        }
                    }
                }
            }
        }
        else {
            showToast(controller: self, message : "Password did not matched", seconds: 1.2)
        }
    }
    
    
    
}


//  MARK:- Extension
extension SignUpController {
    
    
}
