//
//  MapController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, Toastable {
    
    //  MARK: - Variables
    let locationManager = CLLocationManager()
    var inSubView = false
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapHandling()
        configureUI()
        
    }
    
    
    
    //  MARK: - Functions
    func configureUI() {
        self.navigationItem.title = "Maps"
        
        currentLocationButton.roundedCornersWithBorder(cornerRadius: currentLocationButton.frame.height/2)
        currentLocationButton.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))
    }
    
    func mapHandling() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .denied {
            showToast(controller: self, message: "Location services denied. Please enable location services for this app.", seconds: 1.2)
        }
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        
        if inSubView {
            setupCoreLocation()
        }
    }
    
    func setupCoreLocation() {
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
            locationManager.distanceFilter =  100
            locationManager.startUpdatingLocation()
            mapView.setUserTrackingMode(.followWithHeading, animated: true)
            mapView.showsUserLocation = true

        }
    }
    
    func disableLocationServices(){
        locationManager.stopUpdatingLocation()
    }
    
    
    //  MARK: - IBActions
    @IBAction func findMe() {
        currentLocationButton.roatateView(duration: 0.3, roatation: 0.25)
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
        mapView.setRegion(region, animated: true)
    }
    
    
}
