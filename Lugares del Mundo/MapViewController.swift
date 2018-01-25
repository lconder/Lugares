//
//  MapViewController.swift
//  Lugares del Mundo
//
//  Created by Luis Conde on 23/01/18.
//  Copyright © 2018 Luis Conde. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    
    @IBOutlet var mapView: MKMapView!
    
    var place: Place!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        
        self.getLocation()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getLocation() {
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(place.location) { (placemarks, error) in
            
            if error==nil{
            
                for placemark in placemarks! {
                
                    let annotation = MKPointAnnotation()
                    annotation.title = self.place.name
                    annotation.coordinate = (placemark.location?.coordinate)!
                    annotation.subtitle = self.place.type
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                
                }
                
            }else{
                print("Ha habido un error \(String(describing: error?.localizedDescription))")
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}


extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "myPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView: MKPinAnnotationView? = self.mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width: 52, height: 52))
        imageView.image = self.place.image!
        annotationView?.leftCalloutAccessoryView = imageView
        annotationView?.pinTintColor = #colorLiteral(red: 0.03576866599, green: 0.02534572877, blue: 0.768627451, alpha: 1)
        
        return annotationView
        
        
    }

}




