//
//  CustomNavigationBar.swift
//  Exercise 18, 20, 21, 22 Gallary App
//
//  Created by Abhishek Maurya on 07/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class CustomNavigationBar: UIView {

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetUps()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetUps()
    }
    
    private func initialSetUps() {
        
//        register nib
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomNavigationBar", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth , .flexibleHeight]
            self.addSubview(view)
            self.configUI()
        }
    }

    private func configUI() {
        
//        set corner radius for navigation button
        self.leftButton.makeHalfRounded(cornerRadius: self.leftButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.rightButton.makeHalfRounded(cornerRadius: self.rightButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])

        self.titleButton.makeHalfRounded(cornerRadius: self.titleButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])

    }
    
    
}
