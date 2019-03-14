//
//  ViewController.swift
//  Exercise 9 UI Elements
//
//  Created by Abhishek Maurya on 09/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class SignUpController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var profilePictureSelectorButton: UIButton!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var dateOfBirthTextField: UITextField!
    @IBOutlet var eMailtextField: UITextField!
    @IBOutlet var placeOfBirthTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var placePicker: UIPickerView!
    @IBOutlet var privateMsgLabel: UILabel!
    @IBOutlet var privateAccountSwitch: UISwitch!
    
    let profilePicker = UIImagePickerController()
    let citiesName = ["New Delhi", "Noida", "Greater Noida", "Ghaziabad", "Lucknow", "Mumbai", "Kolkata","Chennai"]
    
    override func viewWillAppear(_ animated: Bool) {
        datePicker.isHidden = true
        placePicker.isHidden = true
        
        //Code to make profile picture round
        profilePicker.delegate = self
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        profilePicture.layer.masksToBounds = true
    
        
        for textfield in [dateOfBirthTextField,eMailtextField,placeOfBirthTextField,phoneNumberTextField] {
            textfield!.delegate = self
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placePicker.delegate = self
        self.placePicker.dataSource = self

        userNameTextField.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Protocol for image picker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePicture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Function for opening photo library on click
    @IBAction func uploadPicture(_ sender: Any) {
        profilePicker.allowsEditing = false
        profilePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(profilePicker, animated:  true, completion:  nil)
    }
    
    // Function for picking date if picker is scrolled
    @IBAction func pickingDate(){
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let date = dateFormatter.string(from: selectedDate)
        dateOfBirthTextField.text = date
        datePicker.isHidden = true
        eMailtextField.becomeFirstResponder()
    }
    
    // Textfield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userNameTextField.resignFirstResponder()
            dateOfBirthTextField.becomeFirstResponder()
        }
        else if textField == eMailtextField {
            eMailtextField.resignFirstResponder()
            placeOfBirthTextField.becomeFirstResponder()
        }
        else if textField == phoneNumberTextField {
            phoneNumberTextField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateOfBirthTextField {
            //dateOfBirthTextField.keyboardAppearance = false
            dateOfBirthTextField.resignFirstResponder()
            datePicker.isHidden = false
        }else if textField == placeOfBirthTextField {
            //placeOfBirthTextField.keyboardAppearance = false
            placePicker.isHidden = false
            placeOfBirthTextField.resignFirstResponder()
            //phoneNumberTextField.becomeFirstResponder()
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField{
            let phoneNumber = phoneNumberTextField.text
            if phoneNumber?.count == 10 {
                phoneNumberTextField.resignFirstResponder()
            }

        }
        return true
    }
    
    //Place Picker Protocol
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placeOfBirthTextField.text = citiesName[row]
        placePicker.isHidden = true
        phoneNumberTextField.becomeFirstResponder()
    }
    
    @IBAction func makeAccountPrivate() {
        if privateAccountSwitch.isOn {
            privateMsgLabel.text = "Your account will be kept Private"
        }
        else {
            privateMsgLabel.text = "Your account won't be kept Private "
        }
    }
    
    //Submit Button functionality
    @IBAction func SignUpDone() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DescriptionController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
