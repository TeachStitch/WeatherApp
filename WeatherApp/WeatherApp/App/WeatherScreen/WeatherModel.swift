//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Foundation

typealias HourlyWeatherCompletion = ServiceCompletion<HourlyWeatherModel>

protocol WeatherModelProvider {
    func getHourlyWeather(_ completion: @escaping HourlyWeatherCompletion)
}

class WeatherModel: WeatherModelProvider {
    
    private let networkService: NetworkServiceContext?
    private let locationSevice: LocationServiceContenxt?
    
    init(networkService: NetworkServiceContext?, locationSevice: LocationServiceContenxt?) {
        self.networkService = networkService
        self.locationSevice = locationSevice
    }
    
    func getHourlyWeather(_ completion: @escaping HourlyWeatherCompletion) {
        
    }
}
