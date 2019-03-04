//
//  View5.swift
//  Exercise 7
//
//  Created by Abhishek Maurya on 04/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class View5: UIViewController {
    
    @IBOutlet var jumpToRoot: UIButton!
    @IBOutlet var jumpToPrevious: UIButton!
    @IBOutlet var jumpTo: UIButton!
    @IBOutlet var viewNum: UITextField!
    @IBOutlet var label1: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Fift View Controller"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.presentingViewController != nil){
            label1.text = "Can't load data while presenting"
        }
        else {
            let navArray = self.navigationController?.viewControllers
            if let dataPasser = navArray![0] as? ViewController {
                let data = dataPasser.data.text
                label1.text = data
            }
        }
    }
    
    @IBAction func CallRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func CallPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func CallView() {
        if let text = viewNum.text {
            if let checkNum = Int(text) {
                if (checkNum>0 && checkNum<6) {
                    let storyboard = self.navigationController?.viewControllers
                    self.navigationController?.popToViewController(storyboard![checkNum-1], animated: true)
                }
                else {
                    viewNum.text = ""
                }
            }
            else{
                viewNum.text = ""
            }
        }
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
