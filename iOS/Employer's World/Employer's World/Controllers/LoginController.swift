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
    
    
    
//  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    
//  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = "Login"
        self.title = "LOG IN"
        
    }

    
//  MARK: - IBActions
    @IBAction func loginIn() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
        self.navigationController?.pushViewController(controller, animated: true)
        UserDefaults.standard.set(true, forKey: "isLoggenIn")

    }
    
    @IBAction func signUp() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func forgetPassword() {
        
        
    }

    
}


//  MARK: - Extensions
extension LoginController {
    
}
