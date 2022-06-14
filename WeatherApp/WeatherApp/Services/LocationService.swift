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

class LocationService: LocationServiceContenxt {
    
    var mostRecentLocationCoordinates: CLLocationCoordinate2D? {
        locationManager.location?.coordinate
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        return manager
    }()
    
    func requestLocation() {
//        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
    }
}
