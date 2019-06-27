//
//  ToastableProtocol.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 17/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation
import UIKit

protocol Toastable {
    func showToast(controller: UIViewController, message : String, seconds: Double)
}

extension Toastable {
    func showToast(controller: UIViewController, message : String, seconds: Double = 1.2) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        alert.view.layer.cornerRadius = 8
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
