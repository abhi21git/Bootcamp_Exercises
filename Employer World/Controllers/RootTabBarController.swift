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

        if UserDefault.string(forKey: PROFILESTATUS) == PROFILESTATUSLOGIN {
            
        }
        else if UserDefault.string(forKey: PROFILESTATUS) == PROFILESTATUSSIGNUP {
            
        }
        else if UserDefault.string(forKey: PROFILESTATUS) == PROFILESTATUSPROFILE {
            
        }
    }
    
    
    //  MARK: - IBActions
    
    
}

//  MARK: - Extensions

