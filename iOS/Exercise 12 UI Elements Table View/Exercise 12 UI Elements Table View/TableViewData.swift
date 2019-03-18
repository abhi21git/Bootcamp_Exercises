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
    
//    struct dataOfUser {
//        let profilePicture: UIImage
//        let name: String
//        let age: Int
//        let address: String
//        let details: String
//    }

    var arrayOfData = [DataForm.dataOfUser]()
    
//    override func viewWillAppear(_ animated: Bool) {
//        
//        //to access data from data from directly
//        let navigationController = self.navigationController?.viewControllers
//        let vc = navigationController![0] as! DataForm
//        arrayOfData.append(dataOfUser(profilePicture: vc.profilePicture.image!, name: vc.nameTextField.text!, age: Int(vc.ageTextField.text!)!, address: vc.addressTextField.text!, details: vc.detailsTextField.text!))
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "tableCell")
        
        let navigationController = self.navigationController?.viewControllers
        let vc = navigationController![0] as! DataForm
        arrayOfData = vc.arrayOfData
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func refreshTable() {
        
    }
    
    @IBAction func addMoreData() {
        self.navigationController?.popViewController(animated: true)
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
        
        if indexPath.row%5 == 4 {
            //add activity indicator at bottom
        }
        return cell
    }
    
}
