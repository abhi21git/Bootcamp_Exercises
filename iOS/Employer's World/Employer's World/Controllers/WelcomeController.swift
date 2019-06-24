//
//  WelcomeController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 27/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit


//This view controller will only pe presented once and will only be seen only if user logouts.
class WelcomeController: UIViewController {
    
    //  MARK:- Variables
    
    
    
    //  MARK:- IBOutlets
    @IBOutlet weak var termsTextView: UITextView!
    
    
    //  MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    //  MARK:- Functions
    func configureUI() {
        termsTextView.roundedCornersWithBorder(cornerRadius: 4, borderWidth: 1)
    }
    
    
    //  MARK:- IBActions
    @IBAction func continueClicked() {
        UserDefaults.standard.set(false, forKey: "isFirstTime")
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: "RootTabBarController") as! RootTabBarController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}
