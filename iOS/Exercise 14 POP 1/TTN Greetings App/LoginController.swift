//
//  LoginController.swift
//  TTN Greetings App
//
//  Created by Abhishek Maurya on 04/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class LoginController: UIViewController, Loggable, Roundable, Borderable, Validator {
    

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "UserLoggedIn") == true {
            openProfile()
        }
        addBorder(view: loginButton)
        makeRound(view: loginButton)
        
        makeRound(view: profileImage)
        addBorder(view: profileImage)
    }

    
    @IBAction func login() {
        if (emailValidator(email: userNameTextField.text!) == true && passwordValidator(password: passwordTextField.text!) == true) {
            
            UserDefaults.standard.set(true, forKey: "UserLoggedIn")
            loginCheck(state: UserDefaults.standard.bool(forKey: "UserLoggedIn"), id: userNameTextField.text!, pwd: passwordTextField.text!)
            openProfile()
        }
        else if emailValidator(email: userNameTextField.text!) == false{
            UIView.transition(with: userNameTextField, duration: 0.5, options: .transitionFlipFromBottom, animations: { self.userNameTextField.text = "" }, completion: nil)
        }
        else if passwordValidator(password: passwordTextField.text!) == false {
            UIView.transition(with: passwordTextField, duration: 0.5, options: .transitionFlipFromBottom, animations: { self.passwordTextField.text = "" }, completion: nil)
        }
    }
    
    func openProfile() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileController") as? ProfileController
        self.navigationController?.pushViewController(controller!, animated: true)
    }

}
