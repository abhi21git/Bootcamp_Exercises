//
//  Question1.swift
//  Exercise 11 Auto Layout
//
//  Created by Abhishek Maurya on 12/03/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class Question1: UIViewController {
    
    @IBOutlet var noOfElementsToShow: UITextField!
    @IBOutlet var parentStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noOfElementsToShow.becomeFirstResponder()
        noOfElementsToShow.keyboardType = .numberPad
                // Do any additional setup after loading the view.
    }
    
    @IBAction func ViewGenerator() {
        
        let noOfViews = Int(noOfElementsToShow.text!)
        
        let firstStackView = UIStackView()
        firstStackView.axis = .horizontal
        firstStackView.distribution = .fillEqually
        
        let secondStackView = UIStackView()
        secondStackView.axis = .horizontal
        secondStackView.distribution = .fillEqually
        
        let firstImageView = UIImageView()
        firstImageView.backgroundColor = .blue
        
        let secondImageView = UIImageView()
        secondImageView.backgroundColor = .yellow
        
        let thirdImageView = UIImageView()
        thirdImageView.backgroundColor = .green
        
        let fourthImageView = UIImageView()
        fourthImageView.backgroundColor = .red
        
        //to clear parent stack view so newer views don't get appended
        for views in parentStackView.subviews{
            views.removeFromSuperview()
        }
        
        if noOfViews == 1 {
            parentStackView.addArrangedSubview(firstImageView)
            
        }else if noOfViews == 2 {
            parentStackView.addArrangedSubview(firstImageView)
            parentStackView.addArrangedSubview(secondImageView)
            
        }else if noOfViews == 3 {
            parentStackView.addArrangedSubview(firstImageView)
            parentStackView.addArrangedSubview(secondImageView)
            parentStackView.addArrangedSubview(thirdImageView)
            
        }else if noOfViews == 4 {
            firstStackView.addArrangedSubview(firstImageView)
            firstStackView.addArrangedSubview(secondImageView)
            secondStackView.addArrangedSubview(thirdImageView)
            secondStackView.addArrangedSubview(fourthImageView)

            parentStackView.addArrangedSubview(firstStackView)
            parentStackView.addArrangedSubview(secondStackView)
            
        }else {
            noOfElementsToShow.text = ""
            
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
