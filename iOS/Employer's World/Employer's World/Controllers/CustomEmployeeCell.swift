//
//  CustomEmployeeCell.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class CustomEmployeeCell: UITableViewCell {
    
//  MARK:- Variables
    
    
    
//  MARK:- IBOutlets
    @IBOutlet weak var employeeProfilePicture: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeIDLabel: UILabel!
    

//  MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
//  MARK: - Functions
    func configureUI() {
        employeeProfilePicture.layer.cornerRadius = employeeProfilePicture.frame.height/2
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        //        contentView.layer.cornerRadius = 10
        //        contentView.clipsToBounds = true
        //        contentView.layer.borderWidth = 0.8
        //        contentView.layer.borderColor = UIColor.gray.cgColor
    }
    
    
//  MARK:- IBActions
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
}
