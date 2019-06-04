//
//  EmployeeDetailsControllers.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 22/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit

class EmployeeDetailsControllers: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UIPickerViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//  MARK: - Variables
    var empID: String = "0"
    var employeeArray = [EmployeeDetails]()

//  MARK: - IBOutlets
    @IBOutlet weak var detailsContentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var empIDLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var employeePicture: UIImageView!
    @IBOutlet weak var customSegment: CustomSegment!
    @IBOutlet weak var gallaryAndMapContentView: UIView!
    @IBOutlet weak var employeeMapView: MKMapView!
    @IBOutlet weak var employeeGallary: UICollectionView!
    
    
//  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CollectionGalleryCell", bundle: nil)
        employeeGallary.register(nib, forCellWithReuseIdentifier: "galleryCell")
        
        employeeGallary.delegate = self
        employeeGallary.dataSource = self
        
        configureUI()
        customSegmentHandling()
        apiHandling()
    }
    
    
//  MARK: - Functions
    func configureUI() {
        self.title = "Employee Details"
        
        employeePicture.roundedCornersWithBorder(cornerRadius: employeePicture.frame.height/2)
        nameLabel.roundedCornersWithBorder(cornerRadius: 10)
        ageLabel.roundedCornersWithBorder(cornerRadius: 10)
        empIDLabel.roundedCornersWithBorder(cornerRadius: 10)
        salaryLabel.roundedCornersWithBorder(cornerRadius: 10)
        detailsContentView.roundedCornersWithBorder(cornerRadius: 10, borderWidth: 1)
        gallaryAndMapContentView.roundedCornersWithBorder(cornerRadius: 10, borderWidth: 1)
        customSegment.roundedCornersWithBorder(cornerRadius: 10, borderWidth: 1)
        
        employeeMapView.isHidden = true
        employeeGallary.isHidden = true
    }
    
    func customSegmentHandling() {
        gallarySegmentAction() //so that gallary segement always get selected by default
        
        customSegment.gallaryButton.addTarget(self, action: #selector(self.gallarySegmentAction), for: .touchUpInside)
        customSegment.addToGallaryButton.addTarget(self, action: #selector(self.addToGallarySegmentAction), for: .touchUpInside)
        customSegment.mapButton.addTarget(self, action: #selector(self.mapSegmentAction), for: .touchUpInside)
        customSegment.addToMapButton.addTarget(self, action: #selector(self.addToMapSegmentAction), for: .touchUpInside)
    }
    
    func displayActionSheet() {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Options", preferredStyle: .actionSheet)
        
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
                    DispatchQueue.main.async {
                        self.employeeArray = [data as! EmployeeDetails]
                        self.nameLabel.text = self.employeeArray[0].name
                        self.ageLabel.text = self.employeeArray[0].age
                        self.salaryLabel.text = self.employeeArray[0].salary
                        self.empIDLabel.text = self.employeeArray[0].id
                    }
                }
            }
        })
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
        
    }
    
    
//  MARK: - IBActions
    @objc func gallarySegmentAction() {
        employeeGallary.isHidden = false
        employeeMapView.isHidden = true
    }
    
    @objc func addToGallarySegmentAction() {
        employeeGallary.isHidden = false
        employeeMapView.isHidden = true
        displayActionSheet()
    }
    
    @objc func mapSegmentAction() {
        employeeMapView.isHidden = false
        employeeGallary.isHidden = true
    }
    
    @objc func addToMapSegmentAction() {
        employeeMapView.isHidden = false
        employeeGallary.isHidden = true
    }
}


//  MARK: - Extensions
extension EmployeeDetailsControllers {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "galleryCell", for: indexPath) as! CollectionGalleryCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "PhotoPreviewController") as! PhotoPreviewController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let size = (collectionView.frame.width-30)/2
        return CGSize(width: size, height: size)
    }
}
