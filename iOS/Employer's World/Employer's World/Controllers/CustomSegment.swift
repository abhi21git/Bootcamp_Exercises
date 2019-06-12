//
//  CustomSegment.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 23/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

@IBDesignable class CustomSegment: UIView {
    
    //  MARK:- Variables
    
    
    
    //  MARK:- IBOutlets
    @IBOutlet weak var gallaryButton: UIButton!
    @IBOutlet weak var addToGallaryButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var addToMapButton: UIButton!
    
    
    //  MARK:- LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetUps()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetUps()
    }
    
    private func initialSetUps() {
        //register nib
        let bundle = Bundle(for: type(of: self))
        //        let bundle = Bundle(for: CustomSegment.self)
        let nib = UINib(nibName: "CustomSegment", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth , .flexibleHeight]
            self.addSubview(view)
        }
        
        gallarySegmentSelected()
    }
    
    
    //  MARK: - Functions
    func gallarySegmentSelected() {
        let addImage = UIImage(named: "AddIcon")
        let selectedAddImage = UIImage(named: "AddSelectedIcon")
        
        gallaryButton.backgroundColor = UIColor.gray
        gallaryButton.tintColor = UIColor.white
        addToGallaryButton.backgroundColor = UIColor.gray
        addToGallaryButton.setImage(selectedAddImage, for: .normal)
        
        mapButton.backgroundColor = UIColor.white
        mapButton.tintColor = UIColor.black
        addToMapButton.backgroundColor = UIColor.white
        addToMapButton.setImage(addImage, for: .normal)
    }
    
    func mapSegmentSelected() {
        let addImage = UIImage(named: "AddIcon")
        let selectedAddImage = UIImage(named: "AddSelectedIcon")
        
        mapButton.backgroundColor = UIColor.gray
        mapButton.tintColor = UIColor.white
        addToMapButton.backgroundColor = UIColor.gray
        addToMapButton.setImage(selectedAddImage, for: .normal)
        
        gallaryButton.backgroundColor = UIColor.white
        gallaryButton.tintColor = UIColor.black
        addToGallaryButton.backgroundColor = UIColor.white
        addToGallaryButton.setImage(addImage, for: .normal)
    }
    
    
    //  MARK:- IBActions
    @IBAction func gallaryClicked(_ sender: Any) {
        gallarySegmentSelected()
    }
    
    @IBAction func addToGallaryClicked(_ sender: Any) {
        gallarySegmentSelected()
    }
    
    @IBAction func mapClicked(_ sender: Any) {
        mapSegmentSelected()
    }
    
    @IBAction func addToMapClicked(_ sender: Any) {
        mapSegmentSelected()
    }
    
}
