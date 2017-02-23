//
//  ViewController.swift
//  MyExampleMaps
//
//  Created by Kirill on 08.02.17.
//  Copyright © 2017 Kirill. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var latitudeTextField: UITextField!
   
    @IBOutlet weak var longitudeTextField: UITextField!
    var mapData = MapData()
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var count: Int = 0
    var jsonData: AnyObject?
    
    
    
    // A default location to use when location permission is not granted.
    var location = CLLocation(latitude: 0.0, longitude: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        placesClient = GMSPlacesClient.shared()


        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 64, width: 375, height: 559), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
 
        
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        mapView.isHidden = true
    
    }

    
    @IBAction func findLacation(_ sender: Any) {
        let latitude = Double(latitudeTextField.text!)
        let longitude = Double(longitudeTextField.text!)
        let camera = GMSCameraPosition.camera(withLatitude: latitude!,
                                              longitude: longitude!,
                                              zoom: zoomLevel)
        
            
            if mapView.isHidden {
                mapView.isHidden = false
                mapView.camera = camera
            } else {
                mapView.animate(to: camera)
            }
            

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    
    
    
}




// Delegates to handle events for the location manager.
extension ViewController: CLLocationManagerDelegate {
    
    
    // Handle incoming location events.
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        location = locations.last!
        
       print("Location: \(location)")
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
                mapData.latitude = location.coordinate.latitude
                mapData.longitude = location.coordinate.longitude

                latitudeTextField.text = String(location.coordinate.latitude)
                longitudeTextField.text = String(location.coordinate.longitude)

        if count == 0{
                mapData.addMapDataCD(_longitude: mapData.longitude, _latitude: mapData.latitude)
            count += 1
        }
                mapData.fGeoCoder(location: location)
        
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }

    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
}
