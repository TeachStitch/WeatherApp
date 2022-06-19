//
//  ReusableModels.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 18.06.2022.
//

import Foundation

struct Weather: Decodable {
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case iconName = "icon"
    }
}

struct WeatherInfo: Decodable {
    let minTemperature: Double
    let temperature: Double
    let maxTemperature: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case minTemperature = "temp_min"
        case temperature = "temp"
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

struct City: Decodable {
    let name: String
}

struct Forecast: Decodable {
    let date: Double
    let info: WeatherInfo
    let weather: [Weather]
    let wind: Wind
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case info = "main"
        case weather = "weather"
        case wind
    }
}
