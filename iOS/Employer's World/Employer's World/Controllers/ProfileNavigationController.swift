//
//  ProfileNavigationController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 27/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ProfileNavigationController: UINavigationController {

    //MARK: - Variables
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var profileTabBarItem: UITabBarItem!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "PROFILE"
        profileTabBarItem.title = "PROFILE"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        profileTabBarItem.title = ""
    }

    
    //MARK: - Functions
    
    
    //MARK: - IBActions
    


}
