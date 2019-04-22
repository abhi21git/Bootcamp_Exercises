//
//  EmployeeListController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class EmployeeListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var EmployeeTabBarItem: UITabBarItem!
    @IBOutlet weak var employeeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomEmployeeCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "employeeCell")
        
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        configureUI()
    }
    
    func configureUI() {
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Employeer's World"
        EmployeeTabBarItem.title = "Employee List"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        EmployeeTabBarItem.title = ""
    }
    
}


extension EmployeeListController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! CustomEmployeeCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailsControllers") as! EmployeeDetailsControllers
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
