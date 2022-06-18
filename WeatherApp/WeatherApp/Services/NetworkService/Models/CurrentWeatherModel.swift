//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 17.06.2022.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let cityName: String
    let weather: [Weather]
    let info: WeatherInfo
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case weather
        case info = "main"
        case wind
    }
}
