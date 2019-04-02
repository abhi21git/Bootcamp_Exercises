//
//  Question2.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 25/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

let notificationIdentifier = "boardcastData"

class Question2: UIViewController {
    
    @IBOutlet weak var broadcastMessageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        broadcastMessageTextField.becomeFirstResponder()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func broadcastButtonAction() {
        if broadcastMessageTextField.text != nil {
            NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIdentifier) , object: self , userInfo: [1 : broadcastMessageTextField.text!])
    }
        else {
            UIView.transition(with: broadcastMessageTextField, duration: 0.5, options: .transitionFlipFromRight, animations: {}, completion: nil)
        }
    }
    

    @IBAction func pushViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question2a")
        navigationController?.pushViewController(controller, animated: true)
    }


}
