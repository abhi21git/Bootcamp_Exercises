//
//  ProfileController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    //  MARK: - Variables
    
    
    
    //  MARK: - IBOutlets
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set("profile", forKey: "ProfileStatus")
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "PROFILE"
        //        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        //        self.title = "PROFILE"
        self.navigationItem.title = "Profile"
        
    }
    
    
    //  MARK: - IBActions
    
    
    
}


//  MARK: - Extension
extension ProfileController {
    
    
}
