//
//  MapController.swift
//  Employer's World
//
//  Created by Abhishek Maurya on 19/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, NSFetchedResultsControllerDelegate, Toastable {
    
    //  MARK: - Variables
    let locationManager = CLLocationManager()
    var inSubView = false
    var addAnnotation = false
    var empName = ""
    
    fileprivate lazy var fetchedResultController: NSFetchedResultsController<EmployeeCoordinates> = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest = EmployeeCoordinates.fetchRequest()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "empName", ascending: true)]
        
        let fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchResultController.delegate = self
        
        try? fetchResultController.performFetch()
        return fetchResultController 
    }()
    
    
    //  MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    
    //  MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapHandling()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for item in fetchedResultController.fetchedObjects! {
            let anotationn = MKPointAnnotation()
            anotationn.title = item.empName
            anotationn.coordinate = CLLocationCoordinate2D(latitude: item.lattitude, longitude: item.longitude)
            mapView.addAnnotation(anotationn)
        }
    }
    
    
    
    //  MARK: - Functions
    func configureUI() {
        let longPressAction = UILongPressGestureRecognizer(target: self, action: #selector(dropPin(_ :)))
        mapView.addGestureRecognizer(longPressAction)

        if inSubView {
            currentLocationButton.isHidden = true
            
        }
        else {
            self.navigationItem.title = "Maps"
            currentLocationButton.roundedCornersWithBorder(cornerRadius: currentLocationButton.frame.height/2)
            currentLocationButton.elevateView(shadowOffset: CGSize(width: 1.0, height: 1.0))

        }
    }
    
    func mapHandling() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .denied {
            showToast(controller: self, message: "Location services denied. Please enable location services for this app.")
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
            locationManager.distanceFilter =  10
            locationManager.startUpdatingLocation()
            mapView.setUserTrackingMode(.followWithHeading, animated: true)
            mapView.showsUserLocation = true

        }
    }
    
    func disableLocationServices(){
        locationManager.stopUpdatingLocation()
    }

    
    @objc func dropPin(_ gestureReconizer: UILongPressGestureRecognizer) {
        if addAnnotation && inSubView {
            if gestureReconizer.state == .began {
                let location = gestureReconizer.location(in: mapView)
                let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
                let annotation = MKPointAnnotation()
                
                annotation.coordinate = coordinate
                annotation.title = "Latitude:" + String(format: "%.02f",annotation.coordinate.latitude) + " Longitude:" + String(format: "%.02f",annotation.coordinate.longitude)
                mapView.addAnnotation(annotation)
                saveLocation(name: empName, latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            }
        }
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
    
    func saveLocation(name: String, latitude: Double, longitude: Double ) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let context = appDelegate?.persistentContainer.viewContext {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "EmployeeCoordinates", into: context) as? EmployeeCoordinates
            entity?.empName = name
            entity?.lattitude = latitude
            entity?.longitude = longitude
            
            appDelegate?.saveContext()
        }
    }
    
    
}
