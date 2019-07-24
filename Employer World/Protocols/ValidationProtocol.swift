//
//  ValidationProtocol.swift
//  Employer World
//
//  Created by Abhishek Maurya on 24/07/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

protocol UserDataValidation {
    func isValidEmail(testStr:String) -> Bool
    
    func isValidPassword(testStr:String) -> Bool

}

extension UserDataValidation {
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: testStr)
    }
    
    func isValidPassword(testStr:String) -> Bool {
        let passwordRegEx = "(?=.*[a-zA-Z])(?=.*[0-9]).{8,64}$"
        return NSPredicate(format:"SELF MATCHES %@", passwordRegEx).evaluate(with: testStr)
    }

}
