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
    var gallerySelected = true
    var droppingPins = true
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var detailsContentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var empIDLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var customSegment: CustomSegment!
    @IBOutlet weak var bottomContainerView: UIView!
    
    
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
        bottomContainerView.roundedCornersWithBorder(cornerRadius: 4, borderWidth: 1)
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
                self.showToast(controller: self, message: error.localizedDescription)
            }
            else {
                if data != nil {
                    DispatchQueue.global().async {
                        self.employeeArray = [data as! EmployeeDetails]
                        
                        DispatchQueue.main.async {
                            self.nameLabel.text = self.employeeArray[0].name?.capitalized
                            self.ageLabel.text = self.employeeArray[0].age
                            self.salaryLabel.text = self.employeeArray[0].salary
                            self.empIDLabel.text = self.employeeArray[0].id
                        }
                    }
                }
            }
        })
    }
    
    //function to show action sheet on add button clicked
    func displayActionSheet() {
        
        let optionMenu = UIAlertController(title: "From where to pick images", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in  self.camera()})
        let galleryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in self.photoLibrary()})
        let googleImagesAction = UIAlertAction(title: "Google Image Search", style: .default, handler: { acttion in self.googleImage()})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(galleryAction)
        optionMenu.addAction(googleImagesAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    //Camera action sheet handler
    func camera() {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    //Photo library action sheet handler
    func photoLibrary() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    //Google images action sheet handler
    func googleImage() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "GalleryController") as! GalleryController
        controller.isGalleryVC = false
        controller.tempName = nameLabel.text!
        self.navigationController?.pushViewController(controller, animated: true)

    }

    //function to add and remove subviews for gallary and map controller
    func addChildVC(addAnnotation: Bool = false) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        //to remove pre-existing sub-views
        if self.children.count > 0 {
        let viewControllers = self.children
            for viewController in viewControllers{
                viewController.willMove(toParent: nil)
                viewController.view.removeFromSuperview()
                viewController.removeFromParent()
            }

        }

        if gallerySelected {
            let galleryVC = storyBoard.instantiateViewController(withIdentifier: "GalleryController") as! GalleryController
            
            addChild(galleryVC)
            bottomContainerView.addSubview(galleryVC.view)
            galleryVC.didMove(toParent: self)
        }
        else {
            let mapVC = storyBoard.instantiateViewController(withIdentifier: "MapController") as! MapController
            
            mapVC.addAnnotation = addAnnotation
            mapVC.inSubView = true
            mapVC.empName = self.nameLabel.text!
            addChild(mapVC)
            bottomContainerView.addSubview(mapVC.view)
            mapVC.didMove(toParent: self)
        }
    }
    
    //  MARK: - IBActions
    @objc func gallerySegmentAction() {
        gallerySelected = true
        addChildVC()
    }
    
    @objc func addToGallerySegmentAction() {
        if !gallerySelected{
            gallerySegmentAction()
        }
        displayActionSheet()
        //if gallery is not selected then select gallery and then show options
    }
    
    @objc func mapSegmentAction(addAnnotation: Bool) {
        gallerySelected = false
        addChildVC(addAnnotation: addAnnotation)
    }
    
    @objc func addToMapSegmentAction() {
        if droppingPins {
            droppingPins = false
            mapSegmentAction(addAnnotation: true)
            showToast(controller: self, message: "Dropping annotation enabled")
        }
        else {
            droppingPins = true
            mapSegmentAction(addAnnotation: false)
            showToast(controller: self, message: "Dropping annotation disabled")
        }
    }
}


//  MARK: - Extensions
extension EmployeeDetailsControllers: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // delegate handling to save image by its name from photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageName = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = appDelegate?.persistentContainer.viewContext {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "EmployeeImages", into: context) as? EmployeeImages
            entity?.employeeName = nameLabel.text
            entity?.imageURL = "\(imageName.lastPathComponent)"
            entity?.thumbnailURL = "\(imageName.lastPathComponent)"
            //.lastpathComponent will save the last component from image address that is its name
            
            appDelegate?.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }
    
}
