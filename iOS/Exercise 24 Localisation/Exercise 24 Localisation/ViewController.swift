//
//  ViewController.swift
//  Exercise 24 Localisation
//
//  Created by Abhishek Maurya on 06/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Mark:- Variables
    //================
    
    
    //Mark:- IBOutlets
    //================
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var lottryLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var lottryTextField: UITextField!
    

    
    
    
    //Mark:- LifeCycle
    //================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localisable()
    }
    
    //Mark:- Functions
    //================
    
    func localisable() {
        nameLabel.text = NSLocalizedString("Name", comment: "nameLabel")
        stateLabel.text = NSLocalizedString("State", comment: "stateLabel")
        countryLabel.text = NSLocalizedString("Country", comment: "countryLabel")
        dobLabel.text = NSLocalizedString("Date of Birth", comment: "dateOfBirthLabel")
        lottryLabel.text = NSLocalizedString("Lottery Won", comment: "lotteryWonLabel")
    }
    
    //Mark:- IBActions
    //================
}

//Mark:- Extensions
//=================
extension ViewController {
    
}
