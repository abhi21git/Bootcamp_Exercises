//
//  CustomCollectionCell.swift
//  Exercise 18, 20, 21, 22 Gallary App
//
//  Created by Abhishek Maurya on 07/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.configUI()
    }
    
    private func configUI() {
//        self.imageView.makeHalfRounded(cornerRadius: self.titleLabel.frame.height, maskCorners: [.layerMaxXMaxYCorner , .layerMinXMinYCorner])
        
        self.titleLabel.makeHalfRounded(cornerRadius: self.titleLabel.frame.height/2, maskCorners: [.layerMaxXMinYCorner , .layerMinXMinYCorner])
        
        self.containerView.makeHalfRounded(cornerRadius: self.titleLabel.bounds.height/2, maskCorners: [.layerMinXMaxYCorner , .layerMaxXMaxYCorner , .layerMaxXMinYCorner, .layerMinXMinYCorner])
        
        
    }

}
