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
    var profileData: LoginModel!
    let profile = UserDefaults.standard
    
    
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
    
    //  MARK: - Functions
    func configureUI() {
        self.navigationController?.navigationBar.topItem?.title = "Profile"

        logoutButton.roundedCornersWithBorder(cornerRadius: 4)
        
    }
    
    func loadProfile() {
        
        func loadData() {
            firstNameLabel.text = profile.string(forKey: "fname")?.capitalized
            fullNameLabel.text = (profile.string(forKey: "fname")! + " " + profile.string(forKey: "lname")!).capitalized
            uidNumber.text = profile.string(forKey: "uid")
            subscriptionLabel.text = profile.string(forKey: "subscription")
        }
        
        if profile.bool(forKey: "isLoggenIn") {
            loadData()
        }
        else {
            profile.setValue(profileData.Data.firstName ?? "???", forKey: "fname")
            profile.setValue(profileData.Data.lastName ?? "???", forKey: "lname")
            profile.setValue(profileData.Data.userID ?? "???", forKey: "uid")
            profile.setValue(profileData.Data.subscriptionStatus ?? "???", forKey: "subscription")
            profile.set(true, forKey: "isLoggenIn")
            profile.set("profile", forKey: "ProfileStatus")
            loadData()
        }
    }
    
    
    //  MARK: - IBActions
    @IBAction func logout() {
        //remove child view
        UserDefaults.standard.set(true, forKey: "isFirstTime")
        UserDefaults.standard.set(false, forKey: "isLoggenIn")
        UserDefaults.standard.set("login", forKey: "ProfileStatus")
        UserDefaults.standard.removeObject(forKey: "fname")
        UserDefaults.standard.removeObject(forKey: "lname")
        UserDefaults.standard.removeObject(forKey: "uid")
        UserDefaults.standard.removeObject(forKey: "subscription")
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
}


//  MARK: - Extension
extension ProfileController {
    
    
}
