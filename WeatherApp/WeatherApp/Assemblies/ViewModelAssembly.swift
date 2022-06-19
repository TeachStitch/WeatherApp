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
        .inObjectScope(.transient)
//        .initCompleted { resolver, viewModel in
//            let viewModel = viewModel as? WeatherViewModel
//            let viewController = resolver.resolve(WeatherViewController.self)
//            viewModel?.delegate = viewController
//        }
    }
}
