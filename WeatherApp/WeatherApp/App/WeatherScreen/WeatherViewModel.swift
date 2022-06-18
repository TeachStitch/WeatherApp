//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

protocol WeatherViewModelProvider: AnyObject {
    var hourlyWeatherModel: HourlyWeatherModel? { get }
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
    
    var hourlyWeatherModel: HourlyWeatherModel? {
        didSet {
            delegate?.updateView()
        }
    }
    
    weak var delegate: WeatherViewModelDelegate?
    private let model: WeatherModelProvider?
    
    init(model: WeatherModelProvider?) {
        self.model = model
    }
    
    func onLoad() {
        print(#function)
    }
    
    func locationTapped() {
        
    }
    
    func mapTapped() {
        
    }
}

struct Section: Hashable {
    let kind: WeatherViewController.SectionKind
    var items: [AnyHashable]
}
