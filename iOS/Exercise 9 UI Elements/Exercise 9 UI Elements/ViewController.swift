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
    @IBOutlet var profilePictureSelector: UIButton!
    @IBOutlet var date: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        profilePicture.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func uploadPic(_ sender: Any) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.camera()
        } ))
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.gallary()
        } ))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.present(actionSheet, animated:  true, completion:  nil)
        } ))
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraPickerCOntroller = UIImagePickerController()
            cameraPickerCOntroller.delegate = self
            cameraPickerCOntroller.sourceType = .camera
            self.present(cameraPickerCOntroller, animated: true, completion: nil)
        }
    }
    func gallary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let gallaryPickerCOntroller = UIImagePickerController()
            gallaryPickerCOntroller.delegate = self
            gallaryPickerCOntroller.sourceType = .photoLibrary
            self.present(gallaryPickerCOntroller, animated: true, completion: nil)
        }
    }

    @IBAction func SignUpDone() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DescriptionController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
