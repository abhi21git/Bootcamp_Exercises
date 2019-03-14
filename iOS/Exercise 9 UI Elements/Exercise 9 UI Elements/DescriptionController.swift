//
//  DescriptionController.swift
//  Exercise 9 UI Elements
//
//  Created by Abhishek Maurya on 10/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class DescriptionController: UIViewController {
    
    @IBOutlet var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign up completed"
        descriptionTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func DescriptionDone() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SegmentExample")
        self.navigationController?.pushViewController(controller, animated: true)
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
