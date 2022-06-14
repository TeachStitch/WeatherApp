//
//  ViewModelAssembly.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WeatherViewModelProvider.self) { resolver in
            WeatherViewModel(model: resolver.resolve(WeatherModelProvider.self))
        }
        .initCompleted { resolver, viewModel in
            let viewModel = viewModel as? WeatherViewModel
            viewModel?.delegate = resolver.resolve(WeatherViewController.self)
        }
    }
}
