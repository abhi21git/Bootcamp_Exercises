//
//  Question 3.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 25/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import UserNotifications

class Question3: UIViewController, UNUserNotificationCenterDelegate{
    
    @IBOutlet weak var notificationTitleTextField: UITextField!
    @IBOutlet weak var notificationMessageTextField: UITextField!
    @IBOutlet weak var notificationDateTextField: UITextField!
    @IBOutlet weak var notifcationSwitch: UISwitch!
    @IBOutlet weak var alertLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().delegate = self
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.addTarget(self, action: #selector(Question3.datePickerValueChanged(sender:)), for: .valueChanged)
        notificationDateTextField.inputView = datePicker
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setNotification() {
        if notifcationSwitch.isOn == true {
            //set notification
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = notificationTitleTextField.text!
            notificationContent.body = notificationMessageTextField.text!
            notificationContent.sound = UNNotificationSound(named: UNNotificationSoundName("solemn.m4r"))
            
        }
        else {
            //remove all notification
            
        }
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.medium
        notificationDateTextField.text = formatter.string(from: sender.date)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
