//
//  ProfileController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var ProfileTabBarItem: UITabBarItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Profile"
        ProfileTabBarItem.title = "Profile"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ProfileTabBarItem.title = ""
    }

    

}
