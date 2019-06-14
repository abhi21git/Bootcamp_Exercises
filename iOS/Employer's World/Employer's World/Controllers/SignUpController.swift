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
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    
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
    
    @IBAction func signUp() {
        let signpURL = "https://qa.curiousworld.com/api/v3/SignUp"
        let parameters = [
            "firstName" : firstNameTF.text ?? "",
            "lastName" : lastNameTF.text ?? "",
            "mail" : emailTF.text ?? "",
            "password" : passwordTF.text ?? ""
        ]
        
        NetworkManager.sharedInstance.signup(urlString: signpURL, parameters: parameters) { (data, responseError) in
            if let error = responseError {
                let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.signUp() })) // Retry option to hit api in case internet didn't worked in first place
                self.present(alert, animated: true, completion: nil)
                
            } else {
                if data != nil {
                    DispatchQueue.global().async {
                        let signupResponse = data as! ValidationData
                        print(signupResponse)
                        DispatchQueue.main.async {
                            //add to child view later
                            let alert  = UIAlertController(title: "Alert", message: signupResponse.uStatus.message, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { action in
                                if signupResponse.uStatus.statusCode == 1 {
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

    
    
}


//  MARK:- Extension
extension SignUpController {
    
    
}
