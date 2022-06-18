//
//  LocationService.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Foundation
import CoreLocation

protocol LocationServiceContenxt: AnyObject {
    var mostRecentLocationCoordinates: CLLocationCoordinate2D? { get }
    func requestLocation()
}
// FIXME: Location Service BUG current location
class LocationService: NSObject, LocationServiceContenxt, CLLocationManagerDelegate {
    
    var mostRecentLocationCoordinates: CLLocationCoordinate2D? {
        get {
            return locationManager.location?.coordinate
        }
        set {
            self.mostRecentLocationCoordinates = newValue
        }
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return manager
    }()
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        mostRecentLocationCoordinates = locations.last?.coordinate
    }
}
