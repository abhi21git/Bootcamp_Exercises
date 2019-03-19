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
    @IBOutlet var saveDataButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    
    struct dataOfUser {
        let profilePicture: UIImage
        let name: String
        let age: Int
        let address: String
        let details: String
    }
    var arrayOfData = [dataOfUser]()
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
    
    //Save button action
    @IBAction func savaData() {
        if (nameTextField.text! == "" || ageTextField.text! == "" || addressTextField.text! == "" || detailsTextField.text! == "") {
            //Blank fields not allowed
        }
        else {
            arrayOfData.append(dataOfUser(profilePicture: profilePicture.image!, name: nameTextField.text!, age: Int(ageTextField.text!)!, address: addressTextField.text!, details: detailsTextField.text!))
            profilePicture.image! = UIImage(imageLiteralResourceName: "man.png")
            nameTextField.text! = ""
            ageTextField.text! = ""
            addressTextField.text! = ""
            detailsTextField.text! = ""
            UIView.transition(with: saveDataButton, duration: 1, options: .transitionFlipFromLeft, animations: {}, completion: nil)
        }
    }
    
    //Submit Button Action
    @IBAction func submitAction() {
        if arrayOfData.count > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TableViewCell")
            self.navigationController?.pushViewController(controller, animated: true)
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
