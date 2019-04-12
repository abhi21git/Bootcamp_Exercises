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
    
    var imageData: UIImage!
    let countryCode = Locale.current.regionCode
//    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        msgLabel.isHidden = true
        imageView.isHidden = true
        
        self.title = "CoreLocation"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if CLLocationManager.authorizationStatus() == .notDetermined {
//            locationManager.requestAlwaysAuthorization()
//        }
//            
//        else if CLLocationManager.authorizationStatus() == .denied {
//            print("Location services were previously denied. Please enable location services for this app in Settings.")
//        }
//
//        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
//            locationManager.startUpdatingLocation()
//        }
        
    }
    
    
    @IBAction func showImage() {
        if countryCode! == "US"{
            
            msgLabel.isHidden = true
            imageView.isHidden = false
            
            loadImage()
            self.imageView.image = imageData
        }
        else {
            msgLabel.isHidden = false
            imageView.isHidden = true
        }
    }
    
    
    func loadImage() {
        let imageURL = URL(string: "http://www.newsonair.com/writereaddata/News_Pictures/NAT/2018/Nov/NPIC-201811142185.jpg")
        
        let session = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            guard let data = data else { return }
            let image = UIImage(data: data)
            self.imageData = image
        }
        session.resume()
    }

}
