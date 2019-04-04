//
//  ViewController.swift
//  Exercise 23 Data Persistance
//
//  Created by Abhishek Maurya on 02/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Exercise23: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}



extension Exercise23 {
    // MARK: - Login Controller Check
    
    // If user default have logged in state then don't present login screen
    
    override func viewWillAppear(_ animated: Bool) {
        if (UserDefaults.standard.bool(forKey: "LoggenIn") == false) {
            presentLoginscreen()
        }
    }
    
    // MARK: - Logout Functionality
    
    @IBAction func logout() {
        UserDefaults.standard.removeObject(forKey: "LoggenIn")
        presentLoginscreen()
    }
    
    //function to present login screen
    func presentLoginscreen() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginController") as? LoginController
        self.present(controller!, animated: true, completion: nil)
    }

    
    
    //MARK: - Add Recipe Method
    @IBAction func addRecipe() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddRecipeController") as? AddRecipeController
        self.present(controller!, animated: true, completion: nil)
    }
    
}

