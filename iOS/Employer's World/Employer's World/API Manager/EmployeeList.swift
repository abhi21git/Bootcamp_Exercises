//
//  EmployeeList.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 29/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

struct EmployeeList {
    let id: Int?
    let employee_name: String?
    let employee_salary: Int?
    let employee_age: Int?
    let profile_image: String?
}

extension EmployeeList{
    init(json: JSON) {
        self.id = json["id"] as? Int
        self.employee_name = json["employee_name"] as? String
        self.employee_salary = json["employee_salary"] as? Int
        self.employee_age = json["employee_age"] as? Int
        self.profile_image = json["profile_image"] as? String
    }
}
