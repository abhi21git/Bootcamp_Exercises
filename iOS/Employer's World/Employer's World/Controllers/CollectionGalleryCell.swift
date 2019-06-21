//
//  CollectionGalleryCell.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class CollectionGalleryCell: UICollectionViewCell {
    
    //  MARK:- Variables
    
    
    
    //  MARK:- IBOutlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    //  MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        thumbnailImage.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        thumbnailImage.roundedCornersWithBorder(cornerRadius: imageTitle.frame.height/2)
        imageTitle.roundedCornersWithBorder(cornerRadius: imageTitle.frame.height/2)
        loadingIndicator.roundedCornersWithBorder(cornerRadius: loadingIndicator.frame.height/2)
        thumbnailImage.clipsToBounds = true
        imageTitle.clipsToBounds = true
    }
    
    
    //  MARK:- IBActions
    
}
