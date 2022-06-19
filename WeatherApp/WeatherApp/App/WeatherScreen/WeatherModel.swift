//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Foundation

typealias HourlyWeatherCompletion = (_ result: Result<HourlyWeatherMappedModel, Error>) -> Void

protocol WeatherModelProvider {
    func getHourlyWeather(_ completion: @escaping HourlyWeatherCompletion)
}

class WeatherModel: WeatherModelProvider {
    
    enum LocationError: Error, LocalizedError {
        case notDetermined
        case restricted
        case denied
        case managerError(_ reason: String)
        
        var errorDescription: String? {
            switch self {
            case .notDetermined:
                return "Access is not determined"
            case .restricted:
                return "Access is restricted"
            case .denied:
                return "Access is denied"
            case .managerError:
                return "Manager internal error"
            }
        }
    }
    
    private let networkService: NetworkServiceContext?
    private let locationSevice: LocationServiceContenxt?
    
    init(networkService: NetworkServiceContext?, locationSevice: LocationServiceContenxt?) {
        self.networkService = networkService
        self.locationSevice = locationSevice
    }
    
    func getHourlyWeather(_ completion: @escaping HourlyWeatherCompletion) {
        guard let locationSevice = locationSevice,
            let networkService = networkService else { return }
        
        switch locationSevice.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationSevice.requestLocation { result in
                switch result {
                case .success(let coordinate):
                    networkService.getHourlyWeather(coordinate: coordinate) { result in
                        switch result {
                        case .success(let weather):
                            let hourlyWeather = HourlyWeatherMappedModel(weather)
                            completion(.success(hourlyWeather))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(LocationError.managerError(error.localizedDescription)))
                }
            }
            
        case .notDetermined:
            completion(.failure(LocationError.notDetermined))
        case .restricted:
            completion(.failure(LocationError.restricted))
        case .denied:
            completion(.failure(LocationError.denied))
        @unknown default:
            fatalError()
        }
    }
}
