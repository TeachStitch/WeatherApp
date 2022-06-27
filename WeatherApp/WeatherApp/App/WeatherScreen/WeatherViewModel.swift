//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit
import Swinject

protocol WeatherViewModelProvider: AnyObject {
    var hourlyWeatherModel: HourlyWeatherMappedModel? { get }
    var todayForecasts: [HourlyForecast]? { get }
    func onLoad()
    func locationTapped()
    func retryFetch()
    func mapTapped()
}

protocol WeatherViewModelDelegate: AnyObject {
    func presentAlert(title: String, message: String)
    func pushViewController(_ viewController: UIViewController)
    func updateView()
}

class WeatherViewModel: WeatherViewModelProvider {
        
    var hourlyWeatherModel: HourlyWeatherMappedModel? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateView()
            }
        }
    }
    
    var todayForecasts: [HourlyForecast]? {
        hourlyWeatherModel?.hourlyForecasts.filter { Calendar.current.isDateInToday($0.date) }
    }
    
    weak var delegate: WeatherViewModelDelegate?
    private let model: WeatherModelProvider?
    private let resolver: Resolver
    
    init(model: WeatherModelProvider?, resolver: Resolver) {
        self.model = model
        self.resolver = resolver
    }
    
    func onLoad() {
        getHourlyWeather()
    }
    
    func retryFetch() {
        getHourlyWeather()
    }
    
    func locationTapped() {
        print(#function)
    }
    
    func mapTapped() {
        guard let viewController = resolver.resolve(MapViewController.self) else { return }
        delegate?.pushViewController(viewController)
    }
    
    private func getHourlyWeather() {
        model?.getHourlyWeather { [weak self] result in
            switch result {
            case .success(let hourlyWeather):
                self?.hourlyWeatherModel = hourlyWeather
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        delegate?.presentAlert(title: "Error", message: error.localizedDescription)
    }
}

struct Section: Hashable {
    let kind: WeatherViewController.SectionKind
    var items: [AnyHashable]
}
