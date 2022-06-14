//
//  ServiceAssembly.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(LocationServiceContenxt.self) { _ in LocationService() }
            .inObjectScope(.container)
    }
}
