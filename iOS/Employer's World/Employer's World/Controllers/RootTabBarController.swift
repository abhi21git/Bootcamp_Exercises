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
        if UserDefaults.standard.bool(forKey: "LoggedIn") == true {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = self
        }
    }
    
    
    //  MARK: - IBActions
    
    
}

//  MARK: - Extensions

