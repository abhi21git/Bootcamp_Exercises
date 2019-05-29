//
//  EmployeeListing.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 29/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import Foundation

struct EmployeeListing {
    let id: Int?
    let employee_name: String?
    let employee_salary: Int?
    let employee_age: Int?
    let profile_image: String?
    var results: [EmployeeList] = []
}

extension EmployeeListing{
    init(json: JSON) {
        self.id = json["id"] as? Int
        self.employee_name = json["employee_name"] as? String
        self.employee_salary = json["employee_salary"] as? Int
        self.employee_age = json["employee_age"] as? Int
        self.profile_image = json["profile_image"] as? String
        let EmployeeResult = json["results"] as! [JSON]
        for movieItem in EmployeeResult{
            let movie =  movieItem as? JSON
            self.results.append(movie.flatMap(EmployeeList.init)!)
        }
    }
}
