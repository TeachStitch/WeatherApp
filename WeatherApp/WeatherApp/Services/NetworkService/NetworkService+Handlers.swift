//
//  NetworkService+Handlers.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 17.06.2022.
//

import Foundation

typealias StatusCodeValidationCompletion = (_ validation: CodeValidation) -> Void

protocol StatucCodeHandable {
    func handleServerStatusCode(_ code: Int, completion: @escaping StatusCodeValidationCompletion)
}

extension NetworkService: StatucCodeHandable {
    func handleServerStatusCode(_ code: Int, completion: @escaping StatusCodeValidationCompletion) {
        switch HTTPStatusCode(rawValue: code) {
        case .success, .created:
            completion(.success)
        case .internalServerError:
            completion(.internalServerError)
        case .requestLimit:
            completion(.failure(reason: "Request limit [60 in minute]"))
        case .unauthorized:
            completion(.failure(reason: "API key is not provided"))
        default:
            completion(.unknown)
        }
    }
}
