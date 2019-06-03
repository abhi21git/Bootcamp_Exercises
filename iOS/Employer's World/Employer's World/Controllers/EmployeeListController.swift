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
    var employeeArray = [Employee]()

    
//  MARK: - IBOutlets
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    
//  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHandling()
        configureUI()
        employeeFetching()
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
        self.navigationItem.title = "Employer's World"
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        employeeTableView.isHidden = true
    }
    
    func tableViewHandling() {
        let nib = UINib(nibName: "CustomEmployeeCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "employeeCell")
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
    }
    
    func employeeFetching() {
        
        let employeeListURL = "http://dummy.restapiexample.com/api/v1/employees"

        NetworkManager.sharedInstance.loadEmployee(urlString: employeeListURL, completion: { (data, responseError) in

            if let error = responseError {
                
                print(error.localizedDescription)
                let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.employeeFetching() }))
                self.present(alert, animated: true, completion: nil)
                
                
            } else {
                
                DispatchQueue.main.async {
                    self.employeeArray = data as! [Employee]
                    self.loader.isHidden = true
                    self.employeeTableView.isHidden = false
                    self.employeeTableView.reloadData()
                }
            }
        })
    }

    
    
//  MARK: - IBActions
    
    
}


//  MARK: - Extensions
extension EmployeeListController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! CustomEmployeeCell
        cell.employeeNameLabel.text = employeeArray[indexPath.row].name
        cell.employeeIDLabel.text = employeeArray[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailsControllers") as! EmployeeDetailsControllers
        controller.empID = employeeArray[indexPath.row].id ?? "0"
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
