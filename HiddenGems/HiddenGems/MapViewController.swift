//
//  MapViewController.swift
//  HiddenGems
//
//  Created by Eduardo Barreto-Mendoza on 4/5/21.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        
        //mapView.delegate = self
        super.viewDidLoad()
        checkLocationServices()
        displayHiddengems()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.displayHiddengems()
    }
    
    func displayHiddengems(){
        let query = PFQuery(className:"HiddenGems")
        query.includeKeys(["title", "location"])
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                for object in objects {
                    //print(object.objectId as Any)
                    let annotations = MKPointAnnotation()
                    let location = object["location"] as! PFGeoPoint
                    annotations.subtitle = object["title"] as? String
                    annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                    self.mapView.addAnnotation(annotations)
                }
            }
        }
       mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    

    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }
        else{
            
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }

        if annotation !== mapView.userLocation {
            annotationView?.image = UIImage(named: "HiddenGem1x-1")
        }
        else{
            annotationView = nil
        }
        annotationView?.canShowCallout = true

        return  annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("The annotation was selected \(String(describing: view.annotation?.subtitle))")
    }

}

