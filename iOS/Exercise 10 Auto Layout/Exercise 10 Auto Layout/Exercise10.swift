//
//  Exercise7.swift
//  Exercise 10 Auto Layout
//
//  Created by Abhishek Maurya on 11/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Exercise10: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openQuestion1() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question1")
        self.navigationController!.pushViewController(controller, animated: true)
    }
    @IBAction func openQuestion2() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question2")
        self.navigationController!.pushViewController(controller, animated: true)
    }
    @IBAction func openQuestion3() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question3")
        self.navigationController!.pushViewController(controller, animated: true)
    }
    @IBAction func openQuestion4() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question4")
        self.navigationController!.pushViewController(controller, animated: true)
    }
    @IBAction func openQuestion5() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Question5")
        self.navigationController!.pushViewController(controller, animated: true)
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
