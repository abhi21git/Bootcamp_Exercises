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
    var employeeListArray = [EmployeeDetails]()
    var filteredEmployeeArray = [EmployeeDetails]()
    var refreshControl = UIRefreshControl()
    let progress = Progress(totalUnitCount: 100)

    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<Employees> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = Employees.fetchRequest()
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        fetchResultController.delegate = self
        
        try! fetchResultController.performFetch()
        return fetchResultController
        
    }()

    
    //  MARK: - IBOutlets
    @IBOutlet weak var employeeTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHandling()
        configureUI()
        showSearchBar()
        directEmployeeFetching()
//        employeeLoading()
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
        progressBar.setProgress(0, animated: false)
        
        Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { (timer) in
            if self.progress.completedUnitCount == 60 {
                timer.invalidate()
            }else{
                self.progress.completedUnitCount += 1
                self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
            }
        }
    }
    

    
    func tableViewHandling() {
        let nib = UINib(nibName: CUSTOMEMPLOYEECELLXIBNAME, bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: CUSTOMEMPLOYEECELLNAME)
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        filteredEmployeeArray = employeeListArray
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
                self.employeeListArray = data as! [EmployeeDetails]
                self.filteredEmployeeArray = self.employeeListArray
                DispatchQueue.main.async {
                    
                    for employees in self.employeeListArray {
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
        
        NetworkManager.sharedInstance.loadEmployees(urlString: EMPLOYEEBASEURL, completion: { (data, responseError) in
            
            if let error = responseError {
                self.showToast(controller: self, message: error.localizedDescription, seconds: 1.6)
                DispatchQueue.main.async {
                    let alert = UILabel(frame: CGRect(x: 0, y: 0, width: self.employeeTableView.bounds.size.width, height: (self.tabBarController?.tabBar.frame.height)! + (self.navigationController?.navigationBar.frame.height)! + (self.navigationItem.searchController?.searchBar.frame.height)!  - (self.employeeTableView.frame.height)))
                    alert.text = "Pull down to retry."
                    alert.textAlignment = .center
                    self.employeeTableView.tableHeaderView = alert
                    self.loader.isHidden = true
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
                        if self.progress.completedUnitCount == 100 {
                            timer.invalidate()
                            self.progressBar.isHidden = true
                        }else{
                            self.progress.completedUnitCount += 1
                            self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
                        }
                    }
                }
            }else{
                if data != nil {
                    DispatchQueue.global().async {
                        self.employeeListArray = data as! [EmployeeDetails]
                        self.filteredEmployeeArray = self.employeeListArray
                        
                        DispatchQueue.main.async {
                            Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
                                if self.progress.completedUnitCount == 100 {
                                    timer.invalidate()
                                    self.progressBar.isHidden = true
                                }else{
                                    self.progress.completedUnitCount += 1
                                    self.progressBar.setProgress(Float(self.progress.fractionCompleted), animated: true)
                                }
                            }
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
        employeeTableView.reloadSections([0], with: .fade)
        loader.isHidden = true
        refreshControl.endRefreshing()
    }
    
    
}


//  MARK: - Extensions
extension EmployeeListController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEmployeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CUSTOMEMPLOYEECELLNAME) as! CustomEmployeeCell
        cell.configureCell(employeeData: filteredEmployeeArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        employeeFetching()
        directEmployeeFetching //remove later
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EmployeeDetailsControllers") as! EmployeeDetailsControllers
        controller.employeeDetails = filteredEmployeeArray[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // to keep the height of cell fixed
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredEmployeeArray.removeAll()
        for employee in employeeListArray {
            if (employee.name?.range(of: searchText, options: .caseInsensitive) != nil || employee.id?.range(of: searchText, options:  .caseInsensitive) != nil) {
                filteredEmployeeArray.append(employee)
            }
            else if searchText == BLANKSTRING {
                filteredEmployeeArray = employeeListArray
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
