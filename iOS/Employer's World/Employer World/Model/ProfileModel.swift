//
//  ProfileModel.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 10/06/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

//Model used in logIn()
struct LoginModel: Decodable {
    let Status: UserStatus
    let Data: UserData
    
    enum CodingKeys: String, CodingKey {
        case Status = "status"
        case Data = "data"
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

//Model used in profileApi()
struct ProfileModel: Decodable {
    let Status: UserStatus
    
    enum CodingKeys: String, CodingKey {
        case Status = "status"
    }
}

struct UserStatus: Decodable {
    let message: String?
    let statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case statusCode = "code"
    }
}



