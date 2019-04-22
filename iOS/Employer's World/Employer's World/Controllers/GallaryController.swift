//
//  GallaryController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class GallaryController: UIViewController {

    @IBOutlet weak var GallaryTabBarItem: UITabBarItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = "Gallary"
        GallaryTabBarItem.title = "Gallary"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        GallaryTabBarItem.title = ""
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
