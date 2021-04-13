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
        super.viewDidLoad()
        checkLocationServices()
       // displayHiddengems()

        // Do any additional setup after loading the view.
    }
    
//    func displayHiddengems(){
//        let query = PFQuery(className:"HiddenGems")
//        query.includeKeys(["title", "location"])
//
//        query.findObjectsInBackground { (hiddenGems, error) in
//            if hiddenGems != nil {
//                let annotation = MKPointAnnotation()
//                let location = hiddenGems["location"] as! PFGeoPoint
//                annotation.subtitle = (hiddenGems["title"] as! String)
//                annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//                //annotation.description = (hiddenGem["description"] as! String)
//                self.mapView.addAnnotation(annotation)
//
//            }
//            else{
//                print("Error displaying HiddenGems: \(error)")
//            }
//        }
//    }
    
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
