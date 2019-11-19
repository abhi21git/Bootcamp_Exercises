//
//  CustomGalleryCell.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class CustomGalleryCell: UICollectionViewCell {
    
    //  MARK:- Variables
    var isUnselectedCell = true
    
    
    //  MARK:- IBOutlets
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var selectionIndicator: UILabel!
    
    
    //  MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        contentView.roundedCornersWithBorder(cornerRadius: imageTitle.frame.height/2)
        contentView.clipsToBounds = true
        thumbnailImage.elevateView(shadowOffset: SHADOWOFFSET)
        loadingIndicator.roundedCornersWithBorder(cornerRadius: loadingIndicator.frame.height/2)
        thumbnailImage.clipsToBounds = true
        imageTitle.clipsToBounds = true
        selectionIndicator.roundedCornersWithBorder(cornerRadius: selectionIndicator.frame.height/2, borderWidth: 1, borderColor: UIColor.white.cgColor)
        
    }

    
    //  MARK:- IBActions
    
}