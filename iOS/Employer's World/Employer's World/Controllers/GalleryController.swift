//
//  GalleryController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class GalleryController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

//  MARK: - Variables
    
    
//  MARK: - IBOutlets
    @IBOutlet weak var employeeGallery: UICollectionView!
    
    
//  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CollectionGalleryCell", bundle: nil)
        employeeGallery.register(nib, forCellWithReuseIdentifier: "galleryCell")
        
        employeeGallery.delegate = self
        employeeGallery.dataSource = self
        
        configureUI()
    }

    
//  MARK: - Functions
    func configureUI() {
         self.navigationItem.title = "GALLERY"
    }
    
    
//  MARK: - IBActions
    
    
    
}



//  MARK: - Extensions
extension GalleryController {
    
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
        
        let size = (collectionView.frame.width/2.0)-15
        
        return CGSize(width: size, height: size)
    }

}
