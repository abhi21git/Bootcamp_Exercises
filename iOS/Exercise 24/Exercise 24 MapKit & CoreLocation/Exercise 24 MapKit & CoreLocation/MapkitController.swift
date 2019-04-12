//
//  MapkitController.swift
//  Exercise 24 MapKit & CoreLocation
//
//  Created by Abhishek Maurya on 12/04/19.
//  Copyright © 2019 Abhishek Maurya. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapkitController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var firstCoordinate2D = CLLocationCoordinate2DMake(28.535848,77.346000)
    var secondCoordinate2D = CLLocationCoordinate2DMake(28.495536,77.435147)
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MapKit"

        mapView.mapType = .standard
        mapView.delegate = self
        locationManager.delegate = self
        
        addAnnotations()
        addlines()
        addOverlay()
    }
    
    func addAnnotations(){
        
        let pin1 = MKPointAnnotation()
        pin1.coordinate = firstCoordinate2D
        pin1.title = "TTN"
        pin1.subtitle = "Noida Sector 127"
        mapView.addAnnotation(pin1)
        
        let pin2 = MKPointAnnotation()
        pin2.coordinate = secondCoordinate2D
        pin2.title = "TTN"
        pin2.subtitle = "Noida Sector 144"
        mapView.addAnnotation(pin2)
    }
    
    func addlines(){
        let bhPolyline = MKPolyline(coordinates: [firstCoordinate2D,secondCoordinate2D], count: 2)
        mapView.addOverlays([bhPolyline])
    }
    
    func addOverlay(){
        for location in mapView.annotations{
            let circle = MKCircle(center: location.coordinate, radius: 10.0)
            mapView.addOverlay(circle)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .infoLight)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CallOutController") as! CallOutController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline{
            let polylineRenderer = MKPolylineRenderer(polyline: polyline)
            polylineRenderer.strokeColor = UIColor.red
            polylineRenderer.lineWidth = 2.0
            polylineRenderer.lineDashPattern = [1,1,1,1]
            return polylineRenderer
        }
        
        if let circle = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(circle: circle)
            circleRenderer.fillColor = UIColor(red: 0.1, green: 0.6, blue: 0.8, alpha: 0.2)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 4.0
            return circleRenderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }

}
