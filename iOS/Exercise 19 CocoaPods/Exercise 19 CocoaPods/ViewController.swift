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
                print(JSON)
                
                print("demonstration of alamofire")
                //print("JSON \(jsonResult)")
                print("request url: \(url)")
                print(origin)
            }
        }
    }

}

