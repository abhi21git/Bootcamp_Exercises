//
//  SegmentExample.swift
//  Exercise 9 UI Elements
//
//  Created by Abhishek Maurya on 10/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class SegmentExample: UIViewController {
    
    
    @IBOutlet var selectedItem: UISegmentedControl!
    @IBOutlet var segmentResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Selector example"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SegmentSelectorExample() {
        if selectedItem.selectedSegmentIndex == 0 {
            segmentResult.text = "Employee segment is selected."
        } else if selectedItem.selectedSegmentIndex == 1 {
            segmentResult.text = "Employer segment is selected."
        }
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
