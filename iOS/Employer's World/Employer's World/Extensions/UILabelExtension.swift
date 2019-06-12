//
//  UILabelExtension.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 06/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation
import UIKit

extension UILabel : Toastable {
    
    func toastMessageLabel(message: String)  {
        self.isHidden = false
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.font = UIFont(name: "Montserrat-Light", size: 12.0)
        self.text = message
        self.alpha = 1.0
        self.layer.cornerRadius = 10
        self.clipsToBounds  =  true
        UIView.animate(withDuration: 5.0,
                       delay: 0.1,
                       options: .curveEaseOut,
                       animations: { self.alpha = 0.0 },
                       completion: { (isCompleted) in self.isHidden = true }
        )
    }
}
