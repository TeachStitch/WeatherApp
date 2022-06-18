//
//  Errors.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 17.06.2022.
//

import Foundation

enum ServiceError: Error {
    case undefined
    case invalidURL
    case failedBodySerialization(_ reason: String)
    case failedDecodingResponse(_ reason: String)
    case general(_ message: String)
}

enum HTTPStatusCode: Int {
    case success = 200
    case created = 201
    case internalServerError = 500
    case requestLimit = 429
    case unauthorized = 401
}

enum CodeValidation {
    case success
    case failure(reason: String)
    case internalServerError
    case unknown
}
