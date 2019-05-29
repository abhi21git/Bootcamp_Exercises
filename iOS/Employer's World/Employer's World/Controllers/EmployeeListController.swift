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
    let employeeListURL = "http://dummy.restapiexample.com/api/v1/employees"
    
//  MARK: - IBOutlets
    @IBOutlet weak var employeeTableView: UITableView!

//  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHandling()
        configureUI()
        apiHandling()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let index = self.employeeTableView.indexPathForSelectedRow{
            self.employeeTableView.deselectRow(at: index, animated: true)
        }
    }

    
//  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = "EMPLOYER'S WORLD"
        
    }
    
    func tableViewHandling() {
        let nib = UINib(nibName: "CustomEmployeeCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "employeeCell")
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
    }
    
    func apiHandling() {
        NetworkController.loadEmployee(urlString: employeeListURL) { (employeeList, responseErr) in
            if let err = responseErr{
                debugPrint(err.localizedDescription)
            }else{
                let employeeData = employeeList as? JSON
                let movieCatalog = employeeData.flatMap(EmployeeListing.init)
                
            }
        }
        
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
        controller.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
