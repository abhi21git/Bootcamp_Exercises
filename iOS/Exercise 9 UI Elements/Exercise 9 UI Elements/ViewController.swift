//
//  ViewController.swift
//  Exercise 9 UI Elements
//
//  Created by Abhishek Maurya on 09/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var profilePictureSelectorButton: UIButton!
    @IBOutlet var date: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    let profilePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicker.delegate = self
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        profilePicture.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profilePicture.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadPicture(_ sender: Any) {
        profilePicker.allowsEditing = false
        profilePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(profilePicker, animated:  true, completion:  nil)
    }

    @IBAction func SignUpDone() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DescriptionController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
