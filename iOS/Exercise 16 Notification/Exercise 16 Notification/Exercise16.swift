//
//  ViewController.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 22/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Exercise16: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func openQuestion1() {
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Question1")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func openQuestion2() {
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Question2")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func openQuestion3() {
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Question3")
        self.navigationController?.pushViewController(controller, animated: true)
    }

}



