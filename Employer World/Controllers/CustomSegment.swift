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
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var addToGalleryButton: UIButton!
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
        
        gallerySegmentSelected() //so that gallery segment get selected by default
    }
    
    
    //  MARK: - Functions
    func gallerySegmentSelected() {
        galleryButton.backgroundColor = UIColor.tertiarySystemBackground
        galleryButton.tintColor = UIColor.label
        addToGalleryButton.backgroundColor = UIColor.tertiarySystemBackground
		addToGalleryButton.tintColor = UIColor.label
		
        mapButton.backgroundColor = UIColor.secondaryLabel
        mapButton.tintColor = UIColor.systemBackground
        addToMapButton.backgroundColor = UIColor.secondaryLabel
		addToMapButton.tintColor = UIColor.systemBackground
    }
    
    func mapSegmentSelected() {
		mapButton.backgroundColor = UIColor.tertiarySystemBackground
        mapButton.tintColor = UIColor.label
        addToMapButton.backgroundColor = UIColor.tertiarySystemBackground
		addToMapButton.tintColor = UIColor.label

        galleryButton.backgroundColor = UIColor.secondaryLabel
        galleryButton.tintColor = UIColor.systemBackground
        addToGalleryButton.backgroundColor = UIColor.secondaryLabel
		addToGalleryButton.tintColor = UIColor.systemBackground
    }
    
    
    //  MARK:- IBActions
    @IBAction func galleryClicked(_ sender: Any) {
        gallerySegmentSelected()
    }
    
    @IBAction func addToGalleryClicked(_ sender: Any) {
        gallerySegmentSelected()
    }
    
    @IBAction func mapClicked(_ sender: Any) {
        mapSegmentSelected()
    }
    
    @IBAction func addToMapClicked(_ sender: Any) {
        mapSegmentSelected()
    }
    
}
