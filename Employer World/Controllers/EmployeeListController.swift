//
//  EmployeeListController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class EmployeeListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate, Toastable {
    
    //  MARK: - Variables
    var employeeList = [Employee]()
    var searchedEmployee = [Employee]()
    var refreshControl = UIRefreshControl()
    
    //  MARK: - IBOutlets
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            print("One")
            self.doSomething()
        }
        
        tableViewHandling()
        configureUI()
        employeeFetching()
        showSearchBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let index = self.employeeTableView.indexPathForSelectedRow{
            self.employeeTableView.deselectRow(at: index, animated: false)
        }
    }
    
    func doSomething() {
        print("two")
        DispatchQueue.main.async {
            print("three")
            print("four")
        }
        print("five")
    }
    
    //  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = "Employer's World"
        self.definesPresentationContext = true
        self.tabBarController?.tabBar.elevateView()
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        employeeTableView.addSubview(refreshControl)
    }
    

    
    func tableViewHandling() {
        let nib = UINib(nibName: "CustomEmployeeCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "employeeCell")
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
    }
    
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search employee name or ID"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    
    @discardableResult func employeeFetching() -> Bool {
        loader.isHidden = false
        
        let employeeListURL = "http://dummy.restapiexample.com/api/v1/employees"
        
        NetworkManager.sharedInstance.loadEmployees(urlString: employeeListURL, completion: { (data, responseError) in
            
            if let error = responseError {
                self.showToast(controller: self, message: error.localizedDescription, seconds: 1.6)
                DispatchQueue.main.async {
                    self.loader.isHidden = true
                    let alert = UILabel(frame: CGRect(x: 0, y: 0, width: self.employeeTableView.bounds.size.width, height: self.employeeTableView.bounds.size.height))
                    alert.text = "Pull down to retry."
                    alert.textAlignment = .center
                    self.employeeTableView.tableHeaderView = alert
                }
            }
            else {
                if data != nil {
                    DispatchQueue.global().async {
                        self.employeeList = data as! [Employee]
                        self.searchedEmployee = self.employeeList
                        
                        DispatchQueue.main.async {
                            self.loader.isHidden = true
                            self.employeeTableView.tableHeaderView = .none
                            self.employeeTableView.reloadData()
                        }
                    }
                }
            }
        })
        return true
    }
    
    
    //  MARK: - IBActions
    @objc func refresh() {
        let refreshed = employeeFetching()
        employeeTableView.reloadSections([0], with: .fade)
        if refreshed {
            refreshControl.endRefreshing()
        }
    }
    
    
}


//  MARK: - Extensions
extension EmployeeListController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedEmployee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! CustomEmployeeCell
        cell.employeeNameLabel.text = searchedEmployee[indexPath.row].name?.capitalized
        cell.employeeIDLabel.text = searchedEmployee[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeFetching()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailsControllers") as! EmployeeDetailsControllers
        controller.empID = searchedEmployee[indexPath.row].id ?? "0"
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // to keep the height of cell fixed
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedEmployee.removeAll()
        for employee in employeeList {
            if (employee.name?.range(of: searchText, options: .caseInsensitive) != nil || employee.id?.range(of: searchText, options:  .caseInsensitive) != nil) {
                searchedEmployee.append(employee)
            }
            else if searchText == "" {
                searchedEmployee = employeeList
            }
        }
        employeeTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        employeeTableView.reloadSections([0], with: .fade)
        
    }
    
}
