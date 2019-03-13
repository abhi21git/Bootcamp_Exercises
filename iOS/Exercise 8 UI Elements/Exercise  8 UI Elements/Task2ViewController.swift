//
//  Task2ViewController.swift
//  Exercise  8 UI Elements
//
//  Created by Abhishek Maurya on 12/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Task2ViewController: UIViewController {

    @IBOutlet var task2UIView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Task 2"
        task2UIView.layer.cornerRadius = task2UIView.frame.size.height / 6
        task2UIView.layer.shadowOffset = CGSize(width: 10, height: 10)
        task2UIView.layer.shadowOpacity = 0.9
        task2UIView.layer.shadowRadius = task2UIView.frame.size.height / 6
        task2UIView.clipsToBounds = false
        task2UIView.layer.masksToBounds = false
        //task2UIView.layer.shadowColor = UIColor.init(white: 200.0/255.0, alpha: 5) as! CGColor

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
