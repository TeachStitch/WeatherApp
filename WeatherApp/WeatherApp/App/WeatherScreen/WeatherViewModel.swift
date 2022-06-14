//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

protocol WeatherViewModelProvider: AnyObject {
    func onLoad()
    func locationTapped()
    func mapTapped()
}

protocol WeatherViewModelDelegate: AnyObject {
    func presentAlert(title: String, message: String)
    func pushViewController(_ viewController: UIViewController)
    func updateCell(_ type: WeatherViewController.CellType)
}

class WeatherViewModel: WeatherViewModelProvider {
    
    private let model: WeatherModelProvider?
    weak var delegate: WeatherViewModelDelegate?
    
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
