//
//  ProfileController.swift
//  TTN Greetings App
//
//  Created by Abhishek Maurya on 04/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, checkLogin {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func logout() {
        UserDefaults.standard.set(true, forKey: "UserLoggedIn")
    }


}
