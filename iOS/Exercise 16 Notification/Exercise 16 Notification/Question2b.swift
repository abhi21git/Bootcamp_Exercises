//
//  Question2b.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 29/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Question2b: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationIdentifier), object: nil, queue: nil, using: receiveData)
    }

    
    func receiveData(notification : Notification) {
        messageLabel.text = notification.userInfo![1] as? String
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
