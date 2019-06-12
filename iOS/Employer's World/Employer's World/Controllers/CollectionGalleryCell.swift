//
//  CollectionGallaryCell.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class CollectionGalleryCell: UICollectionViewCell {
    
    //  MARK:- Variables
    
    
    
    //  MARK:- IBOutlets
    @IBOutlet weak var employeeImage: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    
    
    //  MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        employeeImage.layer.cornerRadius = employeeNameLabel.frame.height/2
        employeeNameLabel.layer.cornerRadius = employeeNameLabel.frame.height/2
        employeeImage.clipsToBounds = true
        employeeNameLabel.clipsToBounds = true
    }
    
    
    //  MARK:- IBActions
    
}
