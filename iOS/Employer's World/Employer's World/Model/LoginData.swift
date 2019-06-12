//
//  LoginData.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 10/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

struct LoginData: Decodable {
    let uStatus: UserStatus
    let uData: UserData
    
    enum CodingKeys: String, CodingKey {
        case uStatus = "status"
        case uData = "data"
    }
    
}

struct UserStatus: Decodable {
    let message: String?
    let statusCode: String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case statusCode = "code"
    }
}

struct UserData: Decodable {
    let firstName: String?
    let lastName: String?
    let subscriptionStatus: String?
    let userID: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        case subscriptionStatus = "subscriptionStatus"
        case userID = "uid"
    }
}


