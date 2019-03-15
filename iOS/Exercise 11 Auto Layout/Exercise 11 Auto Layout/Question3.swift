//
//  Question3.swift
//  Exercise 11 Auto Layout
//
//  Created by Abhishek Maurya on 12/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Question3: UIViewController {
    
    @IBOutlet var firstView: UIView!
    @IBOutlet var firstImage: UIImageView!
    @IBOutlet var firstLabel: UILabel!
    @IBOutlet var secondView: UIView!
    @IBOutlet var secondImage: UIImageView!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdView: UIView!
    @IBOutlet var thirdImage: UIImageView!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var fourthView: UIView!
    @IBOutlet var fourthImage: UIImageView!
    @IBOutlet var fourthLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        autoLayoutProgramitically()
        // Do any additional setup after loading the view.
    }
    
    func autoLayoutProgramitically() {
//        let hieghtOfFrame = view.safeAreaLayoutGuide.layoutFrame.size.height
//        let widthOfFrame = view.safeAreaLayoutGuide.layoutFrame.size.width
        
        //self.view.translatesAutoresizingMaskIntoConstraints = false
        
        //first view
        NSLayoutConstraint(item: firstView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: firstView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: firstView, attribute: .height, relatedBy: .equal, toItem: self.secondView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: firstView, attribute: .height, relatedBy: .equal, toItem: self.secondView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: firstView, attribute: .height, relatedBy: .equal, toItem: self.thirdView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: firstView, attribute: .height, relatedBy: .equal, toItem: self.thirdView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        //second view
        NSLayoutConstraint(item: secondView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: secondView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: secondView, attribute: .height, relatedBy: .equal, toItem: self.firstView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: secondView, attribute: .height, relatedBy: .equal, toItem: self.firstView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: secondView, attribute: .height, relatedBy: .equal, toItem: self.fourthView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: secondView, attribute: .height, relatedBy: .equal, toItem: self.fourthView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        //third view
        NSLayoutConstraint(item: thirdView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: thirdView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: thirdView, attribute: .height, relatedBy: .equal, toItem: self.fourthView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: thirdView, attribute: .height, relatedBy: .equal, toItem: self.fourthView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: thirdView, attribute: .height, relatedBy: .equal, toItem: self.firstView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: thirdView, attribute: .height, relatedBy: .equal, toItem: self.firstView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
        //fourth view
        NSLayoutConstraint(item: fourthView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fourthView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fourthView, attribute: .height, relatedBy: .equal, toItem: self.thirdView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fourthView, attribute: .height, relatedBy: .equal, toItem: self.thirdView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fourthView, attribute: .height, relatedBy: .equal, toItem: self.secondView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: fourthView, attribute: .height, relatedBy: .equal, toItem: self.secondView, attribute: .width, multiplier: 1, constant: 0).isActive = true

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
