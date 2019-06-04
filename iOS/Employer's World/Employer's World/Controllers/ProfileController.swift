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
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "PROFILE"

    }
    
    
//  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = "Profile"
//        self.title = "PROFILE"

    }
    
    
//  MARK: - IBActions
    
    
    
}


//  MARK: - Extension
extension ProfileController {
    
    
}
