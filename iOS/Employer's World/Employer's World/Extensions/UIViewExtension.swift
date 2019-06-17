//
//  UIViewExtension.swift
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
    
    //    Function to make all corners round and set border id required
    func roundedCornersWithBorder(cornerRadius: CGFloat, borderWidth: CGFloat = 0, borderColor: CGColor = UIColor.black.cgColor) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    func elevateView(shadowColor: CGColor = UIColor.lightGray.cgColor, shadowOffset: CGSize = CGSize(width: 0.0, height: 1.0), shadowRadius: CGFloat = 4, shadowOpacity: Float = 0.8) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
    }
    
}

