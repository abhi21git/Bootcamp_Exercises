//
//  CoreLocationController.swift
//  Exercise 24 MapKit & CoreLocation
//
//  Created by Abhishek Maurya on 12/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CoreLocationController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    
    let countryCode = Locale.current.regionCode
    
    override func viewDidLoad() {
        super.viewDidLoad()

        msgLabel.isHidden = true
        imageView.isHidden = true
        
        self.title = "CoreLocation"
        
    }
    
    
    @IBAction func loadImage() {
        if countryCode! == "US"{
            
            msgLabel.isHidden = true
            imageView.isHidden = false
            
            let imageURL = URL(string: "http://www.newsonair.com/writereaddata/News_Pictures/NAT/2018/Nov/NPIC-201811142185.jpg")
            
            let urlSession = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
                guard let data = data, error == nil else { return }
                let image = UIImage(data: data)
                self.imageView.image = image
            }
            urlSession.resume()
        }
        else {
            msgLabel.isHidden = false
            imageView.isHidden = true
        }
    }

}
