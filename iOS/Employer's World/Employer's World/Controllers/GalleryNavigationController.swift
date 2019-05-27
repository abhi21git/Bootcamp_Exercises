//
//  GalleryNavigationController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 27/05/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit

class GalleryNavigationController: UINavigationController {

    //MARK:- Variables
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var galleryTabBarItem: UITabBarItem!

    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "GALLERY"
        galleryTabBarItem.title = "GALLERY"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        galleryTabBarItem.title = ""
    }
    
    //MARK:- Functions
    
    
    //MARK:- IBActions
    

}
