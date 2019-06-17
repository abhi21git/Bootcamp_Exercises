//
//  EmployeeListController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class EmployeeListController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate, UIScrollViewDelegate{
    
    //  MARK: - Variables
    var employeeList = [Employee]()
    var searchedEmployee = [Employee]()
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<EmployeeCoreData> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = EmployeeCoreData.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        try! fetchResultController.performFetch()
        return fetchResultController
        
    }()
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    
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
        
        employeeTableView.isHidden = true
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        
        self.tabBarController?.tabBar.layer.masksToBounds = false
        self.tabBarController?.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.tabBarController?.tabBar.layer.shadowRadius = 4
        self.tabBarController?.tabBar.layer.shadowOpacity = 0.8
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        
    }
    
    func tableViewHandling() {
        let nib = UINib(nibName: "CustomEmployeeCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "employeeCell")
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
    }
    
    func showSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search here!"
        //        searchBar.showsCancelButton = false
        searchBar.barTintColor = UIColor.white
        searchBar.layer.shadowColor = UIColor.white.cgColor
        searchBar.sizeToFit()
        employeeTableView.tableHeaderView = searchBar
        //        self.navigationItem.titleView = searchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func employeeFetching() {
        
        let employeeListURL = "http://dummy.restapiexample.com/api/v1/employees"
        
        NetworkManager.sharedInstance.loadEmployee(urlString: employeeListURL, completion: { (data, responseError) in
            
            if let error = responseError {
                
                print(error.localizedDescription)
                let alert  = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in self.employeeFetching() })) // Retry option to hit api in case internet didn't worked in first place
                self.present(alert, animated: true, completion: nil)
                
            } else {
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
        employeeTableView.reloadData()
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
            else if searchText.isEmpty{
                searchedEmployee = employeeList
            }
        }
        employeeTableView.reloadData()
    }
    
}
