//
//  DataPassingController.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 25/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

protocol PassDataDelegate {
    func passData(dictionaryData: [String: [String]] )
}

class DataPassingController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var parentsNameTextField: UITextField!
    
    var delegate: PassDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.endEditing(true)
        nameTextField.text = ""
        ageTextField.text = ""
        parentsNameTextField.text = ""

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitAction() {
        delegate?.passData(dictionaryData: [nameTextField.text! : [ageTextField.text! , parentsNameTextField.text!]])
        self.navigationController?.popViewController(animated: true)
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
