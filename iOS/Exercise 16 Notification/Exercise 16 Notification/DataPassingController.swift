//
//  DataPassingController.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 25/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit


class DataPassingController: UIViewController, PassDataDelegate {
    
    @IBOutlet var resultLabel: UILabel!
    
    var nameData: String?
    var ageData: String?
    var parentsNameData: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.endEditing(true)
        
        resultLabel.text! = "Name: \(nameData!)\nAge: \(ageData!)\nParents Name: \(parentsNameData!)"

        // Do any additional setup after loading the view.
    }
    
    func passData(dictionaryData: [String : [String : String]]) {
        for (name, value) in dictionaryData {
            for (age, pName) in value {
                nameData = name
                ageData = age
                parentsNameData = pName
            }
        }
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
