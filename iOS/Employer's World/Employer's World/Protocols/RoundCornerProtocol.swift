//
//  File.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 22/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    //    Function to make specific corners round of any UI element
    func setRoundedCorners(cornerRadius: CGFloat, maskCorners: CACornerMask ) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = maskCorners
    }
}

