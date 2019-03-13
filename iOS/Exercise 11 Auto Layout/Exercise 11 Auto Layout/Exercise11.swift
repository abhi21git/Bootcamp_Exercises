//
//  ViewController.swift
//  Exercise 11 Auto Layout
//
//  Created by Abhishek Maurya on 12/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Exercise11: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func openQuestion1() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question1")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func openQuestion2() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question2")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func openQuestion3() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question3")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func openQuestion4() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question4")
        self.navigationController?.pushViewController(controller, animated: true)
    }



}

