//
//  LoginController.swift
//  Exercise 23 Data Persistance
//
//  Created by Abhishek Maurya on 03/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}





extension LoginController {
    //MARK: - Login Functionality
    
    //Don't ask for login credentials if user logged in last time
    
    @IBAction func loginCheck() {
        if userNameTextField.text == "" {
            UIView.transition(with: userNameTextField, duration: 0.5, options: .transitionFlipFromRight, animations: {}, completion: nil)
        }else if passwordTextField.text == "" {
            UIView.transition(with: passwordTextField, duration: 0.5, options: .transitionFlipFromRight, animations: {}, completion: nil)
        }else {
            UserDefaults.standard.set(true, forKey: "LoggenIn")
            self.dismiss(animated: true, completion: nil)
        }
    }
}
