//
//  DataForm.swift
//  Exercise 12 UI Elements Table View
//
//  Created by Abhishek Maurya on 18/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class DataForm: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!
    @IBOutlet var detailsTextField: UITextField!
    @IBOutlet var submitButton: UIButton!
    
    let profilePicker = UIImagePickerController()
        
    //Function for tapping on image to open gallary
    @objc func imageTapped() {
        profilePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(profilePicker, animated:  true, completion:  nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.becomeFirstResponder()
        
        //For making Image view clickable to select image
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profilePicture.addGestureRecognizer(tap)
        profilePicker.delegate = self
        
        //For making image view round
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    //Submit Button Action
    @IBAction func submitAction() {
        if (nameTextField.text! == "" || ageTextField.text! == "" || addressTextField.text! == "" || detailsTextField.text! == "") {
            print("Blank fields not allowed")
        }
        else if Int(ageTextField.text!) == nil{
            UIView.transition(with: ageTextField, duration: 0.5, options: .transitionFlipFromRight, animations: { self.ageTextField.text! = "" }, completion: nil)
            print("Enter valid age")
        }
        else {
            
            let navigationController = self.navigationController?.viewControllers
            let vc = navigationController![0] as! TableViewData
            
            vc.arrayOfData.append(TableViewData.dataOfUser(profilePicture: profilePicture.image!, name: nameTextField.text!, age: Int(ageTextField.text!)!, address: addressTextField.text!, details: detailsTextField.text!))
            
            profilePicture.image! = UIImage(imageLiteralResourceName: "man.png")
            nameTextField.text! = ""
            ageTextField.text! = ""
            addressTextField.text! = ""
            detailsTextField.text! = ""
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // Protocol for image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePicture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
