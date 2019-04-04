//
//  ViewController.swift
//  Exercise 14 POP 1
//
//  Created by Abhishek Maurya on 22/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Toastable, ErrorViewProtocol, loading {
    
    @IBOutlet weak var question1Label: UILabel!
    @IBOutlet weak var question3Label: UILabel!
    @IBOutlet weak var activityloader: UIActivityIndicatorView!
    
    let date = Date()
    let errorMsg: String = "Error 404"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        question1Label.text?.append(date.toFormattedString()) //Question 1 output done
        question3Label.text?.append(showError(errorMessage: errorMsg)) //Question 3 output done
            
    }
    
    @IBAction func question2Action() {
        showToast(toastMessage: "Hello") //Question 2 output done
    }
    
    @IBAction func question4Action() {
        activityLoader(loader: activityloader) //Question 4 output done
    }



}




