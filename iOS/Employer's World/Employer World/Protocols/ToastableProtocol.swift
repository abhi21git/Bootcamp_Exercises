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
