//
//  EmployeeModel.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 29/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

struct Employee: Decodable {
    let id: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "employee_name"
    }
}

struct EmployeeDetails: Decodable {
    let id: String?
    let name: String?
    let salary: String?
    let age: String?
    let profileImage: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
        case profileImage = "profile_image"
    }
}


