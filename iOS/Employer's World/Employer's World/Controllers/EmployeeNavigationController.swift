//
//  EmployeeNavigationController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 27/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class EmployeeNavigationController: UINavigationController {

    //MARK:- Variables
    
        
    //MARK:- IBOutlets
    @IBOutlet weak var employeeTabBarItem: UITabBarItem!
        
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.topItem?.title = "EMPLOYER'S WORLD"
        self.employeeTabBarItem.title = "EMPLOYEES"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.employeeTabBarItem.title = ""
    }
        
    //MARK:- Functions
        
        
    //MARK:- IBActions
    

}
