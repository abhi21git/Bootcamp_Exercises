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
        self.navigationController?.navigationBar.topItem?.title = PROFILETITLE

        logoutButton.roundedCornersWithBorder(cornerRadius: 4)
        
    }
    
    func loadProfile() {
        
        func loadData() {
            firstNameLabel.text = UserDefault.string(forKey: "fname")?.capitalized
            fullNameLabel.text = (UserDefault.string(forKey: "fname")! + " " + UserDefault.string(forKey: "lname")!).capitalized
            uidNumber.text = UserDefault.string(forKey: "uid")
            subscriptionLabel.text = UserDefault.string(forKey: "subscription")
        }
        
        switch UserDefault.bool(forKey: LOGINKEY) {
		case true:
            loadData()
		case false:
			UserDefault.setValue(profileData.Data.firstName ?? BLANKSTRING, forKey: "fname")
            UserDefault.setValue(profileData.Data.lastName ?? BLANKSTRING, forKey: "lname")
            UserDefault.setValue(profileData.Data.userID ?? BLANKSTRING, forKey: "uid")
            UserDefault.setValue(profileData.Data.subscriptionStatus ?? BLANKSTRING, forKey: "subscription")
            UserDefault.set(true, forKey: LOGINKEY)
            UserDefault.set(PROFILESTATUSPROFILE, forKey: PROFILESTATUS)
            loadData()
        }
    }
    
    
    //  MARK: - IBActions
    @IBAction func logout() {
        //remove child view
        UserDefault.set(true, forKey: FIRSTTIMEKEY)
        UserDefault.set(false, forKey: LOGINKEY)
        UserDefault.set(PROFILESTATUSLOGIN, forKey: PROFILESTATUS)
        UserDefault.removeObject(forKey: "fname")
        UserDefault.removeObject(forKey: "lname")
        UserDefault.removeObject(forKey: "uid")
        UserDefault.removeObject(forKey: "subscription")
        
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    
}


//  MARK: - Extension
extension ProfileController {
    
    
}
