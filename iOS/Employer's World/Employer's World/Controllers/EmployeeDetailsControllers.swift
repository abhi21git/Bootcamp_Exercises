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
    
    
//  MARK: - IBOutlets
    @IBOutlet weak var detailsContentView: UIView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeAgeLabel: UILabel!
    @IBOutlet weak var employeeDOBLabel: UILabel!
    @IBOutlet weak var employeeSalaryLabel: UILabel!
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
    }
    
    
    
//  MARK: - Functions
    func configureUI() {
        self.title = "EMPLOYEE DETAILS"
        
        employeePicture.roundedCornersWithBorder(cornerRadius: employeePicture.frame.height/2)
        employeeNameLabel.roundedCornersWithBorder(cornerRadius: 10)
        employeeAgeLabel.roundedCornersWithBorder(cornerRadius: 10)
        employeeDOBLabel.roundedCornersWithBorder(cornerRadius: 10)
        employeeSalaryLabel.roundedCornersWithBorder(cornerRadius: 10)
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
