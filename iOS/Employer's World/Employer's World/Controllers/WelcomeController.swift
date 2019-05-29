//
//  WelcomeController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 27/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    //  MARK:- Variables
    
    
    
    //  MARK:- IBOutlets
    
    
    
    //  MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    //  MARK:- Functions
    func configureUI() {
        
    }
    
    
    //  MARK:- IBActions
    @IBAction func continueClicked() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "RootTabBarController") as! RootTabBarController
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
}
