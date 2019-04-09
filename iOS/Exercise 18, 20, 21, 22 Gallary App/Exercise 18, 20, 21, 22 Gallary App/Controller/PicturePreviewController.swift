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
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var authorNameLabel: UILabel!
    
    var authorLink = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addActions()
        
        self.configUI()
        
    }
    
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func titleClicked() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func logoutClicked() {
//        log out functionality here
    }
    
    private func addActions() {
        customNavBar.leftButton.addTarget(self, action: #selector(self.backClicked), for: .touchUpInside)
        
        customNavBar.titleButton.addTarget(self, action: #selector(self.titleClicked), for: .touchUpInside)
        
        customNavBar.rightButton.addTarget(self, action: #selector(self.logoutClicked), for: .touchUpInside)
    }

    private func configUI() {
        self.imageView.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.downloadButton.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.authorButton.makeHalfRounded(cornerRadius: self.downloadButton.frame.height/2, maskCorners: [.layerMaxXMaxYCorner , .layerMaxXMinYCorner])
        
        self.authorNameLabel.makeHalfRounded(cornerRadius: self.authorNameLabel.frame.height/2, maskCorners: [.layerMinXMinYCorner , .layerMaxXMinYCorner])
        
    }
    
    @IBAction func viewAuthor() {
        UIApplication.shared.open(authorLink!, options: [:], completionHandler: nil)
    }

}
