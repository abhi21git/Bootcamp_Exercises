//
//  View4.swift
//  Exercise 7
//
//  Created by Abhishek Maurya on 04/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class View4: UIViewController {
    
    @IBOutlet var jumpToFifth: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fourth View Controller"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CallFifth() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "view5")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func DismissThis() {
        dismiss(animated: true, completion: nil)
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
