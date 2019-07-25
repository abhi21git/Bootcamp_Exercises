//
//  EmployeeListController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class EmployeeListController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate, NSFetchedResultsControllerDelegate, Toastable {
    
    //  MARK: - Variables
    var employeeList = [Employee]()
    var searchedEmployee = [Employee]()
    var refreshControl = UIRefreshControl()
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<Employees> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = Employees.fetchRequest()
        
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
        showSearchBar()
//        employeeLoading()
        directEmployeeFetching()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let index = self.employeeTableView.indexPathForSelectedRow{
            self.employeeTableView.deselectRow(at: index, animated: false)
        }
    }
    
    
    //  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = APPTITLE
        self.definesPresentationContext = true
        self.tabBarController?.tabBar.elevateView()
        loader.roundedCornersWithBorder(cornerRadius: loader.frame.height/6)
        refreshControl.attributedTitle = NSAttributedString(string: PULLTOREFRESHMESSAGE)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        employeeTableView.addSubview(refreshControl)
        navigationController?.navigationBar.addBlurEffect()
    }
    

    
    func tableViewHandling() {
        let nib = UINib(nibName: CUSTOMEMPLOYEECELLXIBNAME, bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: CUSTOMEMPLOYEECELLNAME)
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        searchedEmployee = employeeList
    }
    
    func showSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchController.searchBar.backgroundColor = UIColor.white
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        searchController.searchBar.placeholder = "Search employee name or ID"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func employeeLoading() {
        let fetched = employeeFetching()
        if fetched {
//            loader.isHidden = true
//            employeeTableView.reloadData()
        }
    }
    
    @discardableResult func employeeFetching() -> Bool{
        loader.isHidden = false
        
        NetworkManager.sharedInstance.loadEmployees(urlString: EMPLOYEEBASEURL, completion: { (data, responseError) in
            if let error = responseError {
                self.showToast(controller: self, message: error.localizedDescription, seconds: 1.6)
            }
            else if data != nil {
                self.employeeList = data as! [Employee]
                self.searchedEmployee = self.employeeList
                DispatchQueue.main.async {
                    
                    for employees in self.employeeList {
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                        let managedContext = appDelegate.persistentContainer.viewContext
                        let entity = NSEntityDescription.entity(forEntityName: "Employees", in: managedContext)
                        let employee = NSManagedObject(entity: entity!, insertInto: managedContext)

                        for data in self.fetchedResultController.fetchedObjects! {
                            if data.id == employees.id {
                                //load here
                            }
                            else {
                                employee.setValue(employees.name, forKey: "name")
                                employee.setValue(employees.id, forKey: "id")
                                appDelegate.saveContext()
                            }
                        }
                        
                    }
                
                    self.loader.isHidden = true
                    self.employeeTableView.reloadData()
                }
            }
        })
        return true
    }
    
    @discardableResult func directEmployeeFetching() -> Bool {
        loader.isHidden = false
        
        let url = EMPLOYEEBASEURL + "s"
        NetworkManager.sharedInstance.loadEmployees(urlString: url, completion: { (data, responseError) in
            
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
        employeeLoading()
        let refreshed = employeeFetching()
        employeeTableView.reloadSections([0], with: .fade)
        if refreshed {
            loader.isHidden = true
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CUSTOMEMPLOYEECELLNAME) as! CustomEmployeeCell
        cell.employeeNameLabel.text = searchedEmployee[indexPath.row].name?.capitalized
        cell.employeeIDLabel.text = searchedEmployee[indexPath.row].id
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        employeeFetching()
        directEmployeeFetching //remove later
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailsControllers") as! EmployeeDetailsControllers
        controller.empID = searchedEmployee[indexPath.row].id ?? NULLVALUE
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
            else if searchText == BLANKSTRING {
                searchedEmployee = employeeList
            }
        }
        employeeTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = BLANKSTRING
        searchBar.showsCancelButton = false
        employeeTableView.reloadSections([0], with: .fade)
        
    }
    
}
