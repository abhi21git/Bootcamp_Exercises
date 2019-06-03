//
//  EmployeeDetailsControllers.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 22/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit

class EmployeeDetailsControllers: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

//  MARK: - Variables
    var empID: String = "0"
    var employeeArray = [Employee]()

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
        gallarySegmentAction()
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
        gallarySegmentAction()
        
        customSegment.gallaryButton.addTarget(self, action: #selector(self.gallarySegmentAction), for: .touchUpInside)
        
        customSegment.mapButton.addTarget(self, action: #selector(self.mapSegmentAction), for: .touchUpInside)
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
                
                DispatchQueue.main.async {
                    self.employeeArray = [data as! Employee]
                    self.nameLabel.text = self.employeeArray[0].name
                    self.ageLabel.text = self.employeeArray[0].age
                    self.salaryLabel.text = self.employeeArray[0].salary
                    self.empIDLabel.text = self.employeeArray[0].id
                }
            }
        })
    }
    
    
//  MARK: - IBActions
    @objc func gallarySegmentAction() {
        employeeGallary.isHidden = false
        employeeMapView.isHidden = true
    }
    
    @objc func mapSegmentAction() {
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
