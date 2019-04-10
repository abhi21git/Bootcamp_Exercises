//
//  ViewController.swift
//  Exercise 19 CocoaPods
//
//  Created by Abhishek Maurya on 02/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var question5Label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testrequest() {
        request("https://httpbin.org/get").responseJSON { response in
            if let JSON = response.result.value {
                var jsonResult = JSON as! [String:AnyObject]
                let url = jsonResult["url"] as! String
                let origin = jsonResult["origin"]as! String
                
                self.question5Label.text = "Alomofire demonstration\nURL:\(url)\n\(origin)"
            }
        }
    }

}

