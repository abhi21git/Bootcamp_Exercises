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
    
    func roatateView(duration: CFTimeInterval, roatation: Double = 1) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * roatation * 2
        rotationAnimation.duration = duration
        self.layer.add(rotationAnimation, forKey: nil)
    }
    
    func addAutoContraints(childView: UIViewController) {
        self.addConstraints([
            NSLayoutConstraint(item: childView.view!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childView.view!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childView.view!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: childView.view!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        self.updateConstraints()
    }
    
}

