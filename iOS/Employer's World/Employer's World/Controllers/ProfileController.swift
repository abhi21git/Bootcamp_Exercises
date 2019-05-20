//
//  ProfileController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
//  MARK:- Variables
    
    
    
//  MARK:- IBOutlets
    @IBOutlet weak var profileTabBarItem: UITabBarItem!

    
//  MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "PROFILE"
        profileTabBarItem.title = "PROFILE"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        profileTabBarItem.title = ""
    }

    
//  MARK: - Functions
    func configureUI() {
        
    }
    
    
//  MARK:- IBActions
    
    
    
}


//  MARK:- Extension
extension ProfileController {
    
    
}
