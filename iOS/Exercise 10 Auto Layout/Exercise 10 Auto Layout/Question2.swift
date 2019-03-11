//
//  Question2.swift
//  Exercise 10 Auto Layout
//
//  Created by Abhishek Maurya on 11/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Question2: UIViewController {

    @IBOutlet var imageViewQuestion2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Question 2"
        imageViewQuestion2.layer.cornerRadius = imageViewQuestion2.frame.size.height/2
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
