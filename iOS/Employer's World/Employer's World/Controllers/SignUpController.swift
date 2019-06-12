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
    
    
    
    //  MARK: - IBOutlets
    
    
    
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
        
    }
    
    
    //  MARK: - IBActions
    @IBAction func logIn() {
        self.navigationController?.popViewController(animated: false)
    }
    
    
}


//  MARK:- Extension
extension SignUpController {
    
    
}
