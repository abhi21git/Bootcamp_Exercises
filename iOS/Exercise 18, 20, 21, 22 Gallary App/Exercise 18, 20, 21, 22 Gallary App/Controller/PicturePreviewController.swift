//
//  PicturePreviewController.swift
//  Exercise 18, 20, 21, 22 Gallary App
//
//  Created by Abhishek Maurya on 07/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class PicturePreviewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var customNavBar: CustomNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customNavBar.titleButton.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
        
        self.configUI()
        
    }
    
    @objc func buttonClicked() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    private func configUI() {
        self.imageView.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.downloadButton.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.authorButton.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
    }

}
