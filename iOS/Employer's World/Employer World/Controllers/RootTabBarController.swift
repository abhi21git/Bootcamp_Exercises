//
//  RootTabBarController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    //  MARK: - Variables
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var rootTabBar: UITabBar!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    
    //  MARK: - Functions
    func configureUI() {

        if UserDefaults.standard.string(forKey: "ProfileStatus") == "login" {
            
        }
        else if UserDefaults.standard.string(forKey: "ProfileStatus") == "signup" {
            
        }
        else if UserDefaults.standard.string(forKey: "ProfileStatus") == "profile" {
            
        }
    }
    
    
    //  MARK: - IBActions
    
    
}

//  MARK: - Extensions

