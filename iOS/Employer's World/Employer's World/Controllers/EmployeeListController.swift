//
//  EmployeeListController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class EmployeeListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//  MARK: - Variables

    
//  MARK: - IBOutlets
    @IBOutlet weak var employeeTabBarItem: UITabBarItem!
    @IBOutlet weak var employeeTableView: UITableView!

//  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomEmployeeCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "employeeCell")
        
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        configureUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "EMPLOYER'S WORLD"
        employeeTabBarItem.title = "EMPLOYEES"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        employeeTabBarItem.title = ""
        if let index = self.employeeTableView.indexPathForSelectedRow{
            self.employeeTableView.deselectRow(at: index, animated: true)
        }
    }
    
//  MARK: - Functions
    func configureUI() {
        
    }
    
    
//  MARK: - IBActions
    
    
}


//  MARK: - Extensions
extension EmployeeListController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! CustomEmployeeCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailsControllers") as! EmployeeDetailsControllers
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
