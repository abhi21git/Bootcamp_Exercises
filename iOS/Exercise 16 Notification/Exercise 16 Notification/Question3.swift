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
    @IBOutlet weak var notificationTimeTextField: UITextField!
    @IBOutlet weak var notifcationSwitch: UISwitch!
    @IBOutlet weak var alertLabel: UILabel!
    
    var notificationAccess: Bool!

    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })

        notificationTitleTextField.text = ""
        notificationMessageTextField.text = ""
        notificationTimeTextField.text = ""

        // Do any additional setup after loading the view.
    }
    
    @IBAction func setNotification() {
        
        let content = UNMutableNotificationContent()
        let repeatitiontime = Int(notificationTimeTextField.text!)! * 60
        content.title = notificationTitleTextField.text!
        content.body = notificationMessageTextField.text!
        content.sound = UNNotificationSound(named: .init(rawValue: "solemn.m4r"))
        content.badge = 1
        
        //to set image on notification
        let imageName = "notification"
        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        content.attachments = [attachment]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(repeatitiontime), repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        if notifcationSwitch.isOn == true {
            //set notification
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        else {
            //remove all notification
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //displaying the ios local notification when app is in foreground
        completionHandler([.alert, .badge, .sound])
    }
    

}
