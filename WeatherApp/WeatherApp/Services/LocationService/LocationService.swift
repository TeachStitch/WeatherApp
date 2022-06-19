//
//  LocationService.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Foundation
import CoreLocation

protocol LocationServiceContenxt: AnyObject {
    var authorizationStatus: CLAuthorizationStatus { get }
    func requestAuthorization()
    func requestLocation(_ completion: @escaping LocationService.CoordinatesComplection)
}

class LocationService: NSObject, LocationServiceContenxt, CLLocationManagerDelegate {
    
    typealias CoordinatesComplection = (_ result: Result<CLLocationCoordinate2D, Error>) -> Void
    
    var authorizationStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    
    private var completion: CoordinatesComplection?
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.delegate = self
        return manager
    }()
    
    func requestLocation(_ completion: @escaping CoordinatesComplection) {
        self.completion = completion
        locationManager.requestLocation()
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        completion?(.success(location.coordinate))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(.failure(error))
    }
}
