//
//  HourlyWeatherMappedModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 18.06.2022.
//

import Foundation

struct HourlyWeatherMappedModel {
    let cityName: String
    let hourlyForecasts: [HourlyForecast]
    
    init(_ model: HourlyWeatherModel) {
        cityName = model.city.name
        hourlyForecasts = model.forecasts.map { HourlyForecast($0) }
    }
}

protocol BaseWeatherInfoConfiguration {
    var date: Date { get }
    var iconName: String { get }
    var temperature: Double { get }
}

protocol ExtendedWeatherInfoConfiguration: BaseWeatherInfoConfiguration {
    var minTemperature: Double { get }
    var maxTemperature: Double { get }
    var humidity: Double { get }
    var windSpeed: Double { get }
}

struct HourlyForecast: ExtendedWeatherInfoConfiguration {
    let date: Date
    let minTemperature: Double
    let temperature: Double
    let maxTemperature: Double
    let humidity: Double
    let iconName: String
    let windSpeed: Double
    
    init(_ model: Forecast) {
        date = Date(timeIntervalSince1970: model.date)
        minTemperature = model.info.minTemperature
        temperature = model.info.temperature
        maxTemperature = model.info.maxTemperature
        humidity = model.info.humidity
        windSpeed = model.wind.speed
        iconName = model.weather.first?.iconName ?? "error"
    }
}
