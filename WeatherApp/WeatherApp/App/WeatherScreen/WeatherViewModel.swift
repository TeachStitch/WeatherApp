//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

protocol WeatherViewModelProvider: AnyObject {
    var hourlyWeatherModel: HourlyWeatherMappedModel? { get }
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
    
    weak var delegate: WeatherViewModelDelegate?
    private let model: WeatherModelProvider?
    
    init(model: WeatherModelProvider?) {
        self.model = model
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
        print(#function)
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
