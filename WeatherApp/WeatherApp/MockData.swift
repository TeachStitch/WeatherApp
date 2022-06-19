//
//  MockData.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 14.06.2022.
//

import Foundation

struct MainInfoModel {
    let date: Date
    let weatherIconName: String
    let temperature: Double
    let humidity: Double
    let windSpeed: Double
}

let mainInfoModel = MainInfoModel(date: .now, weatherIconName: "test", temperature: 15, humidity: 68, windSpeed: 13.2)

struct HourlyModel {
    let date: Date
    let temperature: Double
    let weatherIconName: String
}

let hourlyModels = [
    HourlyModel(date: .now, temperature: 12, weatherIconName: "test"),
    HourlyModel(date: Date(timeInterval: 3600, since: .now), temperature: 17, weatherIconName: "test"),
    HourlyModel(date: Date(timeInterval: 7200 * 2, since: .now), temperature: 22, weatherIconName: "test"),
    HourlyModel(date: Date(timeInterval: 3600 * 3, since: .now), temperature: 9, weatherIconName: "test"),
    HourlyModel(date: Date(timeInterval: 3600 * 4, since: .now), temperature: 0, weatherIconName: "test"),
    HourlyModel(date: Date(timeInterval: 3600 * 5, since: .now), temperature: -5, weatherIconName: "test")
]

struct WeekModel {
    let date: Date
    let currentTemperature: Double
    let averageTemperature: Double
    let weatherIconName: String
}

let weekModels = [
    WeekModel(date: .now, currentTemperature: 7, averageTemperature: 14, weatherIconName: "test"),
    WeekModel(date: .now, currentTemperature: 12, averageTemperature: 14, weatherIconName: "test"),
    WeekModel(date: .now, currentTemperature: 19, averageTemperature: 15, weatherIconName: "test"),
    WeekModel(date: .now, currentTemperature: 32, averageTemperature: 16, weatherIconName: "test"),
    WeekModel(date: .now, currentTemperature: 44, averageTemperature: 13, weatherIconName: "test"),
    WeekModel(date: .now, currentTemperature: 27, averageTemperature: 23, weatherIconName: "test"),
    WeekModel(date: .now, currentTemperature: 19, averageTemperature: 33, weatherIconName: "test")
]
