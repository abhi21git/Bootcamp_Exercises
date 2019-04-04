//
//  AddRecipeController.swift
//  Exercise 23 Data Persistance
//
//  Created by Abhishek Maurya on 04/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import CoreData

class AddRecipeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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




extension AddRecipeController {
    
    //MARK: - Recipe add functionality
    @IBAction func saveRecipe() {
        

        self.dismiss(animated: true, completion: nil)
    }
}
