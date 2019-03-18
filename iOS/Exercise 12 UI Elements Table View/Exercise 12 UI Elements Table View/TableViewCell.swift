//
//  TableViewCell.swift
//  Exercise 12 UI Elements Table View
//
//  Created by Abhishek Maurya on 18/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        profilePicture.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
