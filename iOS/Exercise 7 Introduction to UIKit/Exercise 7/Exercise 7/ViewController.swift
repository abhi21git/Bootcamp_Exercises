//
//  ViewController.swift
//  Exercise 7
//
//  Created by Abhishek Maurya on 04/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var data: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func CallSecond() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "view2")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func presentSecond() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "view2")
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func presentThird() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "view3")
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func presentFourth() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "view4")
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func presentFifth() {
        let controller = storyboard!.instantiateViewController(withIdentifier: "view5")
        self.present(controller, animated: true, completion: nil)
    }

}

