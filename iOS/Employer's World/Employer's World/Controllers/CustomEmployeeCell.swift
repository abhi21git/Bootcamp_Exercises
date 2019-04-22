//
//  CustomEmployeeCell.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class CustomEmployeeCell: UITableViewCell {
    
    @IBOutlet weak var employeeProfilePicture: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        configureUI()
    }
    
    func configureUI() {
        employeeProfilePicture.layer.cornerRadius = employeeProfilePicture.frame.height/2
    }

    
}
