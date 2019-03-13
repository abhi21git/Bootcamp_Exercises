//
//  Task5ViewController.swift
//  Exercise  8 UI Elements
//
//  Created by Abhishek Maurya on 12/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Task1ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Task 1"
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let tabItem1 = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        let tabItem2 = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        let tabItem3 = storyboard.instantiateViewController(withIdentifier: "ThirdViewController")
        tabItem1.tabBarItem = UITabBarItem(title: "My Tab 1", image: nil, tag: 0)
        tabItem2.tabBarItem = UITabBarItem(title: "My Tab 2", image: nil, tag: 1)
        tabItem3.tabBarItem = UITabBarItem(title: "My Tab 3", image: nil, tag: 2)
        viewControllers = [tabItem1, tabItem2, tabItem3]
        
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
