//
//  ProfileController.swift
//  TTN Greetings App
//
//  Created by Abhishek Maurya on 04/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, Loggable, Roundable, Borderable {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    let date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = UserDefaults.standard.string(forKey: "uid")
        
        dateLabel.text = date.toFormattedString()
        
        addBorder(view: logoutButton)
        makeRound(view: logoutButton)
        
        makeRound(view: profileImage)
        addBorder(view: profileImage)
        
    }
    
    @IBAction func logout() {
        UserDefaults.standard.set(false, forKey: "UserLoggedIn")
        self.navigationController?.popViewController(animated: true)
    }


}
