//
//  SignUpController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, UserDataValidation, Toastable {
    
    //  MARK: - Variables
    var passwordMatched = false
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailChecker: UILabel!
    @IBOutlet weak var passwordChecker: UILabel!
    @IBOutlet weak var samePasswordChecker: UILabel!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }    
    
    //  MARK: - Functions
    func configureUI() {
        [firstNameTF, lastNameTF, emailTF, passwordTF, confirmPasswordTF].forEach { textFields in
            textFields?.delegate = self
        }
        [firstNameTF, lastNameTF, emailTF, passwordTF, confirmPasswordTF].forEach { textFields in
            textFields?.elevateView(shadowOffset: SHADOWOFFSET)
        }
        [firstNameTF, lastNameTF, emailTF, passwordTF].forEach { textFields in
            textFields?.returnKeyType = UIReturnKeyType.next
        }
        confirmPasswordTF.returnKeyType = UIReturnKeyType.done
        firstNameTF.becomeFirstResponder()
        self.navigationController?.navigationBar.topItem?.title = SIGNUPTITLE
        self.navigationItem.hidesBackButton = true
        signupButton.roundedCornersWithBorder(cornerRadius: 4)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //  MARK: - IBActions
    @IBAction func login() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
        
        UserDefault.set(PROFILESTATUSLOGIN, forKey: PROFILESTATUS)
    }
    
    @IBAction func emailValidation() {
        //TODO reduce hits like login
        
        let parameters = ["mail" : emailTF.text!]
        
        NetworkManager.sharedInstance.profileApi(urlString: EMAILVALIDATIONURL, parameters: parameters, completion: { result in
            switch result {
            case .success(let data):
                DispatchQueue.global().async {
                    let status = data as! ProfileModel
                    DispatchQueue.main.async {
                        if status.Status.statusCode == 1 {
                            self.emailChecker.textColor = UIColor.red
                            self.emailChecker.text = "!"
                            self.showToast(controller: self, message: "Email ID already in use")
                        }
                        else {
                            self.emailChecker.text = ""
                        }
                    }
                }
            case .failure( _): break
            }
        })
    }
    
    
    @IBAction func passwordValidation() {
        if passwordTF.text!.isEmpty {
            passwordChecker.text = CheckStatus.none.rawValue
        }
        else if passwordTF.text!.count < 8 {
            passwordChecker.textColor = UIColor.red
            passwordChecker.text = CheckStatus.incorrect.rawValue
        }
        else {
            passwordChecker.textColor = UIColor.green
            passwordChecker.text = CheckStatus.correct.rawValue
        }
    }
    
    @IBAction func passwordMatching() {
        if confirmPasswordTF.text!.isEmpty{
            samePasswordChecker.text = CheckStatus.none.rawValue
        }
        else if (passwordTF.text == confirmPasswordTF.text){
            samePasswordChecker.textColor = UIColor.green
            samePasswordChecker.text = CheckStatus.correct.rawValue
            passwordMatched = true
        }
        else {
            samePasswordChecker.textColor = UIColor.red
            samePasswordChecker.text = CheckStatus.incorrect.rawValue
            passwordMatched = false
        }
    }
    
    @IBAction func signUp() {
        if passwordMatched {
            let parameters = [
                "firstName" : firstNameTF.text ?? BLANKSTRING,
                "lastName" : lastNameTF.text ?? BLANKSTRING,
                "mail" : emailTF.text ?? BLANKSTRING,
                "password" : passwordTF.text ?? BLANKSTRING
            ]
            
            NetworkManager.sharedInstance.profileApi(urlString: SIGNUPURL, parameters: parameters) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.global().async {
                        let signupResponse = data as! ProfileModel
                        self.showToast(controller: self, message: signupResponse.Status.message!, seconds: 2)
                        DispatchQueue.main.async {
                            if signupResponse.Status.statusCode == 1 {
                                self.login()
                            }
                        }
                    }
                case .failure(let error):
                    self.showToast(controller: self, message: error.localizedDescription)
                }
            }
        }
        else {
            showToast(controller: self, message : "Password did not matched")
        }
    }
    
    
}


//  MARK:- Extension
extension SignUpController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTF {
            firstNameTF.resignFirstResponder()
            lastNameTF.becomeFirstResponder()
        }
        if textField == lastNameTF {
            lastNameTF.resignFirstResponder()
            emailTF.becomeFirstResponder()
        }
        if textField == emailTF {
            emailTF.resignFirstResponder()
            passwordTF.becomeFirstResponder()
        }
        if textField == passwordTF {
            passwordTF.resignFirstResponder()
            confirmPasswordTF.becomeFirstResponder()
        }
        if textField == confirmPasswordTF {
            confirmPasswordTF.resignFirstResponder()
        }
        return true
    }
    
}
