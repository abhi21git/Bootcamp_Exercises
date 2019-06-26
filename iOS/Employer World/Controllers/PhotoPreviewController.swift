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
        loadImage(urlString: imageURL!)
    }
    
    
    //  MARK:- Functions
    func configureUI() {
        self.title = "Preview"
        imageLoader.roundedCornersWithBorder(cornerRadius: imageLoader.frame.height/6)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        
    }
    
    func loadImage(urlString: String) {
        UIImage.loadFrom(url: urlString, completion: { image in
            self.imageView.image = image
            self.imageLoader.isHidden = true
        })
    }

    
    
    //  MARK:- IBActions
    
    
    
}


//  MARK:- Extensions
extension PhotoPreviewController {
    
}
