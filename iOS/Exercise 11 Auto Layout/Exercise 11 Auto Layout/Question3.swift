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
        
//        view.translatesAutoresizingMaskIntoConstraints = false
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        secondView.translatesAutoresizingMaskIntoConstraints = false
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        fourthView.translatesAutoresizingMaskIntoConstraints = false
        
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        secondImage.translatesAutoresizingMaskIntoConstraints = false
        thirdImage.translatesAutoresizingMaskIntoConstraints = false
        fourthImage.translatesAutoresizingMaskIntoConstraints = false
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        fourthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        autoLayoutProgramitically()
        // Do any additional setup after loading the view.
    }
    
    func autoLayoutProgramitically() {
        
        //first view
        NSLayoutConstraint(item: firstView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: firstView, attribute: .bottom, relatedBy: .equal, toItem: self.thirdView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: firstView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: firstView, attribute: .right, relatedBy: .equal, toItem: self.secondView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: firstView, attribute: .height, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .height, multiplier: 0.5, constant: 0).isActive = true
        
        NSLayoutConstraint(item: firstView, attribute: .width, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .width, multiplier: 0.5, constant: 0).isActive = true
        
        
            //first Image
            NSLayoutConstraint(item: firstImage, attribute: .top, relatedBy: .equal, toItem: self.firstView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: firstImage, attribute: .bottom, relatedBy: .equal, toItem: self.firstLabel, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: firstImage, attribute: .left, relatedBy: .equal, toItem: self.firstView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: firstImage, attribute: .right, relatedBy: .equal, toItem: self.firstView, attribute: .right, multiplier: 1, constant: 8).isActive = true

            //first label
            NSLayoutConstraint(item: firstLabel, attribute: .top, relatedBy: .equal, toItem: self.firstImage, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: firstLabel, attribute: .bottom, relatedBy: .equal, toItem: self.firstView, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: firstLabel, attribute: .left, relatedBy: .equal, toItem: self.firstView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: firstLabel, attribute: .right, relatedBy: .equal, toItem: self.firstView, attribute: .right, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: firstLabel, attribute: .height, relatedBy: .equal, toItem: self.firstLabel, attribute: .height, multiplier: 1, constant: 21).isActive = true

        
        //second view
        NSLayoutConstraint(item: secondView, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: secondView, attribute: .bottom, relatedBy: .equal, toItem: self.fourthView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: secondView, attribute: .left, relatedBy: .equal, toItem: self.firstView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: secondView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: secondView, attribute: .height, relatedBy: .equal, toItem: self.firstView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: secondView, attribute: .width, relatedBy: .equal, toItem: self.firstView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
            //second Image
            NSLayoutConstraint(item: secondImage, attribute: .top, relatedBy: .equal, toItem: self.secondView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: secondImage, attribute: .bottom, relatedBy: .equal, toItem: self.secondLabel, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: secondImage, attribute: .left, relatedBy: .equal, toItem: self.secondView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: secondImage, attribute: .right, relatedBy: .equal, toItem: self.secondView, attribute: .right, multiplier: 1, constant: 8).isActive = true
        
            //second label
            NSLayoutConstraint(item: secondLabel, attribute: .top, relatedBy: .equal, toItem: self.secondImage, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: secondLabel, attribute: .bottom, relatedBy: .equal, toItem: self.secondView, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: secondLabel, attribute: .left, relatedBy: .equal, toItem: self.secondView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: secondLabel, attribute: .right, relatedBy: .equal, toItem: self.secondView, attribute: .right, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: secondLabel, attribute: .height, relatedBy: .equal, toItem: self.secondLabel, attribute: .height, multiplier: 1, constant: 21).isActive = true

        
        //third view
        NSLayoutConstraint(item: thirdView, attribute: .top, relatedBy: .equal, toItem: self.firstView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: thirdView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: thirdView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: thirdView, attribute: .right, relatedBy: .equal, toItem: self.fourthView, attribute: .left, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: thirdView, attribute: .height, relatedBy: .equal, toItem: self.fourthView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: thirdView, attribute: .width, relatedBy: .equal, toItem: self.fourthView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
            //third Image
            NSLayoutConstraint(item: thirdImage, attribute: .top, relatedBy: .equal, toItem: self.thirdView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: thirdImage, attribute: .bottom, relatedBy: .equal, toItem: self.thirdLabel, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: thirdImage, attribute: .left, relatedBy: .equal, toItem: self.thirdView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: thirdImage, attribute: .right, relatedBy: .equal, toItem: self.thirdView, attribute: .right, multiplier: 1, constant: 8).isActive = true
        
            //third label
            NSLayoutConstraint(item: thirdLabel, attribute: .top, relatedBy: .equal, toItem: self.thirdImage, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: thirdLabel, attribute: .bottom, relatedBy: .equal, toItem: self.thirdView, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: thirdLabel, attribute: .left, relatedBy: .equal, toItem: self.thirdView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: thirdLabel, attribute: .right, relatedBy: .equal, toItem: self.thirdView, attribute: .right, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: thirdLabel, attribute: .height, relatedBy: .equal, toItem: self.thirdLabel, attribute: .height, multiplier: 1, constant: 21).isActive = true
        
        
        //fourth view
        NSLayoutConstraint(item: fourthView, attribute: .top, relatedBy: .equal, toItem: self.secondView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: fourthView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: fourthView, attribute: .left, relatedBy: .equal, toItem: self.thirdView, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: fourthView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: fourthView, attribute: .height, relatedBy: .equal, toItem: self.secondView, attribute: .height, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: fourthView, attribute: .width, relatedBy: .equal, toItem: self.secondView, attribute: .width, multiplier: 1, constant: 0).isActive = true
        
            //fourth Image
            NSLayoutConstraint(item: fourthImage, attribute: .top, relatedBy: .equal, toItem: self.fourthView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: fourthImage, attribute: .bottom, relatedBy: .equal, toItem: self.fourthLabel, attribute: .top, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: fourthImage, attribute: .left, relatedBy: .equal, toItem: self.fourthView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: fourthImage, attribute: .right, relatedBy: .equal, toItem: self.fourthView, attribute: .right, multiplier: 1, constant: 8).isActive = true
        
            //fourth label
            NSLayoutConstraint(item: fourthLabel, attribute: .top, relatedBy: .equal, toItem: self.fourthImage, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: fourthLabel, attribute: .bottom, relatedBy: .equal, toItem: self.fourthView, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: fourthLabel, attribute: .left, relatedBy: .equal, toItem: self.fourthView, attribute: .left, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: fourthLabel, attribute: .right, relatedBy: .equal, toItem: self.fourthView, attribute: .right, multiplier: 1, constant: 8).isActive = true
        
            NSLayoutConstraint(item: fourthLabel, attribute: .height, relatedBy: .equal, toItem: self.fourthLabel, attribute: .height, multiplier: 1, constant: 21).isActive = true

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
