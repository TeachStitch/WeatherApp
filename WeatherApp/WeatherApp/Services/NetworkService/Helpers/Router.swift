//
//  Router.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 17.06.2022.
//

import Foundation

protocol Route {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [String: LosslessStringConvertible] { get }
    var httpMethod: HTTPMethod { get }
    var body: [String: Any]? { get }
}

extension Route {
    var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = .init(queryItems)
        components.queryItems?.append(.init(name: "appid", value: NetworkService.APIKEY))
        return components.url
    }
}

struct Router: Route {
    let scheme: String
    let host: String
    let path: String
    let queryItems: [String: LosslessStringConvertible]
    let httpMethod: HTTPMethod
    let body: [String: Any]?
    
    init(path: String,
         queryItems: [String: LosslessStringConvertible],
         scheme: String = "https",
         host: String = "api.openweathermap.org",
         httpMethod: HTTPMethod = .get,
         body: [String: Any]? = nil) {
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
        self.httpMethod = httpMethod
        self.body = body
    }
}
