//
//  Question1.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 25/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit



class Question1: UIViewController, PassDataDelegate{

    @IBOutlet var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Question 1"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addData() {
        let controller: DataPassingController = self.storyboard?.instantiateViewController(withIdentifier: "DataPassingController") as! DataPassingController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func passData(dictionaryData: [String : [String]]) {
        resultLabel.text! = "\(dictionaryData)"
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
