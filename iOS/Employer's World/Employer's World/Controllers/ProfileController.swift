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
    var profileData: LoginData!
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var uidNumber: UILabel!
    @IBOutlet weak var subscriptionLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        loadProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
        UserDefaults.standard.set("profile", forKey: "ProfileStatus")
        
    }
    
    
    //  MARK: - Functions
    func configureUI() {
//        self.title = "PROFILE"
        self.navigationItem.title = "Profile"
        logoutButton.roundedCornersWithBorder(cornerRadius: 4)
        
    }
    
    func loadProfile() {
        firstNameLabel.text = profileData.uData.firstName
        fullNameLabel.text = profileData.uData.firstName! + " " + profileData.uData.lastName!
        uidNumber.text = profileData.uData.userID
        subscriptionLabel.text = profileData.uData.subscriptionStatus
        
    }
    
    
    //  MARK: - IBActions
    @IBAction func logout() {
        //remove child view
        self.navigationController?.popViewController(animated: false)
    }
    
    
}


//  MARK: - Extension
extension ProfileController {
    
    
}
