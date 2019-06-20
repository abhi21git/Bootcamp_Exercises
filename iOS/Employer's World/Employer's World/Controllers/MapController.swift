//
//  MapController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    //  MARK: - Variables
    let locationManager = CLLocationManager()
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var employeeMapView: MKMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeMapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .denied {
            let alert = UIAlertController(title: "Location Permission Denied", message: "Location services denied. Please enable location services for this app.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        
        configureUI()
        
    }
    
    
    
    //  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = "Maps"
        
        currentLocationButton.roundedCornersWithBorder(cornerRadius: currentLocationButton.frame.height/2)
        currentLocationButton.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
        
    }
    
    func setupCoreLocation(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            enableLocationServices()
        default:
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func enableLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter =  10
            locationManager.startUpdatingLocation()
            employeeMapView.setUserTrackingMode(.followWithHeading, animated: true)
        }
    }
    
    func disableLocationServices(){
        locationManager.stopUpdatingLocation()
    }
    
    
    //  MARK: - IBActions
    @IBAction func findMe() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi/2
        rotationAnimation.duration = 0.4
        currentLocationButton.layer.add(rotationAnimation, forKey: nil)
        setupCoreLocation()
    }
    
    
}


//  MARK:- Extensions
extension MapController {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways:
            print("authorized")
            
        case .denied:
            print("not authorized")
            
        default:
            print("unknown")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        disableLocationServices()
        
        let location = locations.last!
        let coordinations =  CLLocationCoordinate2D(latitude: location.coordinate.latitude,longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.2,longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        employeeMapView.setRegion(region, animated: true)
    }
    
    
}
