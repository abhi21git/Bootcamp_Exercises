//
//  LoginController.swift
//  TTN Greetings App
//
//  Created by Abhishek Maurya on 04/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class LoginController: UIViewController, checkLogin {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    @IBAction func login() {
        UserDefaults.standard.set(false, forKey: "UserLoggedIn")
        
        loginCheck(state: UserDefaults.standard.bool(forKey: "UserLoggedIn"), id: userNameTextField.text!, pwd: passwordTextField.text!)
        
        let storyboard = 
    }

}
