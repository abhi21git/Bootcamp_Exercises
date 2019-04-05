//
//  ViewController.swift
//  Exercise 12 UI Elements Table View
//
//  Created by Abhishek Maurya on 18/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class TableViewData: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    struct dataOfUser {
        let profilePicture: UIImage
        let name: String
        let age: Int
        let address: String
        let details: String
    }
    
    var limitIndex = false
    var arrayOfData = [dataOfUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Data"
        
        tableView.delegate = self
        tableView.dataSource = self

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableCell")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addMoreData() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DataForm")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func refreshData() {
        if limitIndex == false{
            tableView.reloadData()
        }
    }
    
    //Protocols for table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
    
        cell.profilePicture.image = arrayOfData[indexPath.row].profilePicture
        cell.nameLabel.text = arrayOfData[indexPath.row].name
        cell.ageLabel.text = String(arrayOfData[indexPath.row].age)
        cell.adressLabel.text = arrayOfData[indexPath.row].address
        cell.detailsLabel.text = arrayOfData[indexPath.row].details

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
            
            let lastElement = arrayOfData.count - 1
            if indexPath.row == lastElement {
                if indexPath.row > 9{
                    tableView.reloadData()
                    limitIndex = true
                }
                tableView.tableFooterView?.isHidden = true
            }
        }
    }
    

}
