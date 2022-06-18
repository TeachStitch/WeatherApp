//
//  ModelAssembly.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Swinject

class ModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WeatherModelProvider.self) { _ in WeatherModel() }
            .inObjectScope(.transient)
    }
}
