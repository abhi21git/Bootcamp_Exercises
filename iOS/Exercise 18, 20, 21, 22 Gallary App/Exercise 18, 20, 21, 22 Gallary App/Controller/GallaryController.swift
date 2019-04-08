//
//  GallaryController.swift
//  Exercise 18, 20, 21, 22 Gallary App
//
//  Created by Abhishek Maurya on 07/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class GallaryController: UIViewController {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        customNavBar.leftButton.isHidden = true
                
        let nib = UINib.init(nibName: "CustomCollectionCell", bundle: nil)
        photoCollectionView.register(nib, forCellWithReuseIdentifier: "CustomCollectionCell")

    }
}

extension GallaryController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 900
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionCell", for: indexPath) as! CustomCollectionCell
        return cell
    }
    
    
    //    to set height and width of cell in proportion to screen size and maintaning aspect ration of 4:3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.width/2.0)-12
        let cellHeight = cellWidth*(4/3)
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
