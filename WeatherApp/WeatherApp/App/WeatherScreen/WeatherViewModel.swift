//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

protocol WeatherViewModelProvider: AnyObject {
    var hourlyWeatherModel: Observable<HourlyWeatherMappedModel> { get }
    func onLoad()
    func locationTapped()
    func mapTapped()
}

protocol WeatherViewModelDelegate: AnyObject {
    func presentAlert(title: String, message: String)
    func pushViewController(_ viewController: UIViewController)
    func updateView()
}

class WeatherViewModel: WeatherViewModelProvider {
    
    var hourlyWeatherModel: Observable<HourlyWeatherMappedModel> = Observable(nil)
    
    weak var delegate: WeatherViewModelDelegate?
    private let model: WeatherModelProvider?
    
    init(model: WeatherModelProvider?) {
        self.model = model
    }
    
    func onLoad() {
        model?.getHourlyWeather { result in
            switch result {
            case .success(let hourlyWeather):
                self.hourlyWeatherModel.value = hourlyWeather
            case .failure(let error):
                self.handleError(error)
            }
        }
    }
    
    func locationTapped() {
        print(#function)
    }
    
    func mapTapped() {
        print(#function)
    }
    
    private func handleError(_ error: Error) {
        print(error)
    }
}

struct Section: Hashable {
    let kind: WeatherViewController.SectionKind
    var items: [AnyHashable]
}

final class Observable<T> {
    
    var value: T? {
        didSet {
            listeners.forEach {
                $0(value)
            }
        }
    }
    
    private var listeners: [((T?) -> Void)] = []
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
