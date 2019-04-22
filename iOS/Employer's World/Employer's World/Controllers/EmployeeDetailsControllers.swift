//
//  EmployeeDetailsControllers.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 22/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class EmployeeDetailsControllers: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var employeeNameTextField: UITextField!
    @IBOutlet weak var employeeAgeTextField: UITextField!
    @IBOutlet weak var employeeDOBTextField: UITextField!
    @IBOutlet weak var employeeSalaryTextField: UITextField!
    @IBOutlet weak var employeePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        contentView.layer.cornerRadius = 20
        
    }
    

}
