//
//  SignUpController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
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
        
        signupButton.roundedCornersWithBorder(cornerRadius: 4)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //  MARK: - IBActions
    @IBAction func login() {
        self.navigationController?.popViewController(animated: false)
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
                            //show toast later
                        }
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
                    let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.signUp() })) // Retry option to hit api in case internet didn't worked in first place
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    if data != nil {
                        DispatchQueue.global().async {
                            let signupResponse = data as! ProfileModel
                            DispatchQueue.main.async {
                                //add to child view later
                                let alert  = UIAlertController(title: "Alert", message: signupResponse.Status.message, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                                    if signupResponse.Status.statusCode == 1 {
                                        self.navigationController?.popViewController(animated: false)
                                    }
                                })) // Retry option to hit api in case internet didn't worked in first place
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Alert", message: "Invalid email or password", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        else {
            showToast(controller: self, message : "Password didn't matched", seconds: 2.0)
        }
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

    
    
}


//  MARK:- Extension
extension SignUpController {
    
    
}
