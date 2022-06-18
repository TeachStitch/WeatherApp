//
//  ModelAssembly.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Swinject

class ModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WeatherModelProvider.self) { resolver in
            WeatherModel(
                networkService: resolver.resolve(NetworkServiceContext.self),
                locationSevice: resolver.resolve(LocationServiceContenxt.self)
            )
        }
        .inObjectScope(.transient)
    }
}
