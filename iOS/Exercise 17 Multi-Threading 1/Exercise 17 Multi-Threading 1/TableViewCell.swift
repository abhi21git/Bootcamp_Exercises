//
//  TableViewCell.swift
//  Exercise 17 Multi-Threading 1
//
//  Created by Abhishek Maurya on 20/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var lapLabel: UILabel!
    @IBOutlet var lapTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
