//
//  ViewControllerAssembly.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Swinject

class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WeatherViewController.self) { resolver in
            let viewModel = resolver.resolve(WeatherViewModelProvider.self) as? WeatherViewModel
            let viewController = WeatherViewController(viewModel: viewModel)
            viewModel?.delegate = viewController
            return viewController
        }
        .inObjectScope(.transient)
    }
}
