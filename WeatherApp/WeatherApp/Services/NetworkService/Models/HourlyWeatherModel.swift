//
//  HourlyWeatherModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 18.06.2022.
//

import Foundation

struct HourlyWeatherModel: Decodable {
    let city: City
    let forecasts: [Forecast]
    
    enum CodingKeys: String, CodingKey {
        case city
        case forecasts = "list"
    }
}
