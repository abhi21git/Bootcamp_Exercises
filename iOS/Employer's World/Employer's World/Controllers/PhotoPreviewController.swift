//
//  PhotoPreviewController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 24/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class PhotoPreviewController: UIViewController {
    
    //  MARK:- Variables
    var imageURL: String?    
    
    //  MARK:- IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLoader: UIActivityIndicatorView!
    
    
    
    //  MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        loadImage(url: imageURL!)
    }
    
    
    //  MARK:- Functions
    func configureUI() {
        self.title = "Preview"
        imageLoader.roundedCornersWithBorder(cornerRadius: imageLoader.frame.height/6)
    }
    
    func loadImage(url: String) {
//        let url = URL(string: url)
        UIImage.loadFrom(url: url, completion: { image in
            self.imageView.image = image
            self.imageLoader.isHidden = true
        })
    }

    
    
    //  MARK:- IBActions
    
    
    
}


//  MARK:- Extensions
extension PhotoPreviewController {
    
}
