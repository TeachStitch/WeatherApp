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
            WeatherViewModel(model: resolver.resolve(WeatherModelProvider.self), resolver: resolver)
        }
        .inObjectScope(.transient)
        
        container.register(MapViewModelProvider.self) { _ in
            MapViewModel()
        }
        .inObjectScope(.transient)
    }
}
