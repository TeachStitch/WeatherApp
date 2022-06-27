//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 17.06.2022.
//

import Foundation
import CoreLocation.CLAvailability

typealias ServiceCompletion<T: Decodable> = (_ result: Result<T, ServiceError>) -> Void

protocol NetworkServiceContext {
    func getCurrentWeather(coordinate: CLLocationCoordinate2D, completion: @escaping ServiceCompletion<CurrentWeatherModel>)
    func getHourlyWeather(coordinate: CLLocationCoordinate2D, completion: @escaping ServiceCompletion<HourlyWeatherModel>)
}

class NetworkService: NetworkServiceContext {
    static let APIKEY = "81217fe46215428e9346fa56bbc45f5f"
    
    private enum Constants {
        static let basePath = "/data/2.5"
        static let metricQuery = (name: "units", value: "metric")
    }
    
    private let decoder = JSONDecoder()
    
    func execute<T>(_ route: Route, completion: @escaping ServiceCompletion<T>) where T: Decodable {
        guard let url = route.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = route.httpMethod.rawValue
        request.timeoutInterval = 10
        if let body = route.body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body)
            } catch let error {
                completion(.failure(.failedBodySerialization(error.localizedDescription)))
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(.general(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let data = data else { return }
            self.handleServerStatusCode(httpResponse.statusCode) { validation in
                switch validation {
                case .success:
                    do {
                        let responseModel = try self.decoder.decode(T.self, from: data)
                        completion(.success(responseModel))
                    } catch let error {
                        print(error)
                        completion(.failure(.failedDecodingResponse(error
                            .localizedDescription)))
                    }
                    
                case .failure(let reason):
                    completion(.failure(.general(reason)))
                case .internalServerError:
                    completion(.failure(.general("Internal server error")))
                case .unknown:
                    completion(.failure(.undefined))
                }
            }
        }
        
        task.resume()
    }
    
    func getCurrentWeather(coordinate: CLLocationCoordinate2D, completion: @escaping ServiceCompletion<CurrentWeatherModel>) {
        let path = "\(Constants.basePath)/weather"
        let queryItems: [String: LosslessStringConvertible] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude,
            Constants.metricQuery.name: Constants.metricQuery.value
        ]
        let router = Router(path: path, queryItems: queryItems)
        execute(router, completion: completion)
    }
    
    func getHourlyWeather(coordinate: CLLocationCoordinate2D, completion: @escaping ServiceCompletion<HourlyWeatherModel>) {
        let path = "\(Constants.basePath)/forecast"
        let queryItems: [String: LosslessStringConvertible] = [
            "lat": coordinate.latitude,
            "lon": coordinate.longitude,
            Constants.metricQuery.name: Constants.metricQuery.value
        ]
        let router = Router(path: path, queryItems: queryItems)
        execute(router, completion: completion)
    }
}
