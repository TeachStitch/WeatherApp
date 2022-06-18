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
    
    struct Weather: Decodable {
        let iconName: String
        
        enum CodingKeys: String, CodingKey {
            case iconName = "icon"
        }
    }
    
    struct WeatherInfo: Decodable {
        let minTemperature: Double
        let maxTemperature: Double
        let humidity: Double
        
        enum CodingKeys: String, CodingKey {
            case minTemperature = "temp_min"
            case maxTemperature = "temp_max"
            case humidity
        }
    }
    
    struct Wind: Decodable {
        let speed: Double
        let direction: Int
        
        enum CodingKeys: String, CodingKey {
            case speed
            case direction = "deg"
        }
    }
}
