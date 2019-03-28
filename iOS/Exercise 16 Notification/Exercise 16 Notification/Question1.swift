//
//  Question1.swift
//  Exercise 16 Notification
//
//  Created by Abhishek Maurya on 25/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

protocol PassDataDelegate {
    func passData(dictionaryData: [String : [ String : String]])
}

class Question1: UIViewController{

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var parentsNameTextField: UITextField!
    
    var delegate: PassDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.becomeFirstResponder()
        nameTextField.text = ""
        ageTextField.text = ""
        parentsNameTextField.text = ""
        self.title = "Question 1"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitAction() {
        let controller: DataPassingController = self.storyboard?.instantiateViewController(withIdentifier: "DataPassingController") as! DataPassingController
        
        //since delgate is assigned before passing I am here assigning delegate to the controller where data is sent rather than self
        delegate = controller
        
        delegate?.passData(dictionaryData: [nameTextField.text! : [ageTextField.text! : parentsNameTextField.text!]])
        
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
