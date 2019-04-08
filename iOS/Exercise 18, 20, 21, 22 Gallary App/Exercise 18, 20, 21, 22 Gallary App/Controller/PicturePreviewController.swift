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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configUI()
        
    }
    

    private func configUI() {
        self.imageView.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.downloadButton.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.authorButton.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
    }

}
