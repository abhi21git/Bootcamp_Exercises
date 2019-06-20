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
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIButton!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHandling()
        configureUI()
        employeeFetching()
        showSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let index = self.employeeTableView.indexPathForSelectedRow{
            self.employeeTableView.deselectRow(at: index, animated: false)
        }
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = "Employer's World"
        self.definesPresentationContext = true
        employeeTableView.isHidden = true
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        refreshButton.roundedCornersWithBorder(cornerRadius: refreshButton.frame.height/2)
        refreshButton.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        self.tabBarController?.tabBar.elevateView()

        
    }
    
    func tableViewHandling() {
        let nib = UINib(nibName: "CustomEmployeeCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "employeeCell")
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
    }
    
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search employee name or ID"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func employeeFetching() {
        loader.isHidden = false
        
        let employeeListURL = "http://dummy.restapiexample.com/api/v1/employees"
        
        NetworkManager.sharedInstance.loadEmployee(urlString: employeeListURL, completion: { (data, responseError) in
            
            if let error = responseError {
                
                let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .destructive, handler: { action in self.employeeFetching() })) // Retry option to hit api in case internet didn't worked in first place
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                    self.loader.isHidden = true
                    self.showToast(controller: self, message: "No internet connection.", seconds: 1.2)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                if data != nil {
                    DispatchQueue.global().async {
                        self.employeeList = data as! [Employee]
                        self.searchedEmployee = self.employeeList
                        
                        DispatchQueue.main.async {
                            self.loader.isHidden = true
                            self.employeeTableView.isHidden = false
                            self.employeeTableView.reloadData()
                        }
                    }
                }
            }
        })
    }
    
    
    //  MARK: - IBActions
    @IBAction func refreshData() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi
        rotationAnimation.duration = 0.4
        refreshButton.layer.add(rotationAnimation, forKey: nil)
        employeeTableView.reloadSections([0], with: .fade)
        employeeTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        employeeFetching()
        
    }
    
}


//  MARK: - Extensions
extension EmployeeListController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedEmployee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") as! CustomEmployeeCell
        cell.employeeNameLabel.text = searchedEmployee[indexPath.row].name
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
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        employeeTableView.reloadSections([0], with: .fade)
        
    }
    
}
