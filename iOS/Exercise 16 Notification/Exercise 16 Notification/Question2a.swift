//
//  Question2a.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 29/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Question2a: UIViewController {

    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationIdentifier), object: nil, queue: nil, using: receiveData)
        
    }
    
    func receiveData(notification : Notification) {
        let messageData: String = notification.userInfo![1] as! String
        messageLabel.text = messageData
    }
    
    @IBAction func pushViewController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question2b")
        navigationController?.pushViewController(controller, animated: true)
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
