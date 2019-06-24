//
//  EmployeeDetailsControllers.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 22/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class EmployeeDetailsControllers: UIViewController, Toastable {
    
    //  MARK: - Variables
    var empID: String = "0"
    var employeeArray = [EmployeeDetails]()
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var detailsContentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var empIDLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var customSegment: CustomSegment!
    @IBOutlet weak var galleryAndMapContentView: UIView!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        customSegmentHandling()
        apiHandling()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        self.title = "Employee Details"
        
        nameLabel.roundedCornersWithBorder(cornerRadius: 4)
        ageLabel.roundedCornersWithBorder(cornerRadius: 4)
        empIDLabel.roundedCornersWithBorder(cornerRadius: 4)
        salaryLabel.roundedCornersWithBorder(cornerRadius: 4)
        detailsContentView.roundedCornersWithBorder(cornerRadius: 4)
        detailsContentView.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0), shadowRadius: 4)
        galleryAndMapContentView.roundedCornersWithBorder(cornerRadius: 4, borderWidth: 1)
        customSegment.roundedCornersWithBorder(cornerRadius: 4, borderWidth: 1)
        
    }
    
    func customSegmentHandling() {
        gallerySegmentAction() //so that gallery segement always get selected by default
        
        customSegment.galleryButton.addTarget(self, action: #selector(self.gallerySegmentAction), for: .touchUpInside)
        customSegment.addToGalleryButton.addTarget(self, action: #selector(self.addToGallerySegmentAction), for: .touchUpInside)
        customSegment.mapButton.addTarget(self, action: #selector(self.mapSegmentAction), for: .touchUpInside)
        customSegment.addToMapButton.addTarget(self, action: #selector(self.addToMapSegmentAction), for: .touchUpInside)
    }
    
    
    func apiHandling() {
        
        let employeeURL = "http://dummy.restapiexample.com/api/v1/employee/\(empID)"
        
        NetworkManager.sharedInstance.loadSelectedEmployee(urlString: employeeURL, completion: { (data, responseError) in
            
            if let error = responseError {
                
                print(error.localizedDescription)
                let alert  = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                if data != nil {
                    DispatchQueue.global().async {
                        self.employeeArray = [data as! EmployeeDetails]
                        
                        DispatchQueue.main.async {
                            self.nameLabel.text = self.employeeArray[0].name
                            self.ageLabel.text = self.employeeArray[0].age
                            self.salaryLabel.text = self.employeeArray[0].salary
                            self.empIDLabel.text = self.employeeArray[0].id
                        }
                    }
                }
            }
        })
    }
    
    func displayActionSheet() {
        
        let optionMenu = UIAlertController(title: "Choose options", message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in  self.camera()})
        let galleryAction = UIAlertAction(title: "Gallery", style: .default, handler: { action in self.photoLibrary()})
        let googleImagesAction = UIAlertAction(title: "Google Images", style: .default, handler: { acttion in self.googleImage()})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(galleryAction)
        optionMenu.addAction(googleImagesAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func camera() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func googleImage() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "GalleryController") as! GalleryController
        controller.isGalleryVC = false
        controller.tempName = nameLabel.text!
        self.navigationController?.pushViewController(controller, animated: true)

    }

    func addChildVC(isGallery: Bool) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let galleryVC = storyBoard.instantiateViewController(withIdentifier: "GalleryController") as! GalleryController
        let mapVC = storyBoard.instantiateViewController(withIdentifier: "MapController") as! MapController
        
        if self.children.count > 0 {
            let viewControllers:[UIViewController] = self.children
            for viewContoller in viewControllers{
                viewContoller.willMove(toParent: nil)
                viewContoller.view.removeFromSuperview()
                viewContoller.removeFromParent()
            }
        }
        
        if isGallery {
            addChild(galleryVC)
            galleryAndMapContentView.addSubview(galleryVC.view)
            galleryVC.didMove(toParent: self)
        }
        else {
            addChild(mapVC)
            galleryAndMapContentView.addSubview(mapVC.view)
            mapVC.didMove(toParent: self)
        }
    }
    
    //  MARK: - IBActions
    @objc func gallerySegmentAction() {
        addChildVC(isGallery: true)
    }
    
    @objc func addToGallerySegmentAction() {
        gallerySegmentAction()
        displayActionSheet()
    }
    
    @objc func mapSegmentAction() {
        addChildVC(isGallery: false)
    }
    
    @objc func addToMapSegmentAction() {
        mapSegmentAction()
    }
}


//  MARK: - Extensions
extension EmployeeDetailsControllers: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // delegate handling to save data from photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageName = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let context = appDelegate?.persistentContainer.viewContext {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "EmployeeImages", into: context) as? EmployeeImages
            entity?.employeeName = nameLabel.text
            entity?.imageURL = "\(imageName.lastPathComponent)"
            entity?.thumbnailURL = "\(imageName.lastPathComponent)"
            appDelegate?.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }
    
}
