//
//  Observable.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 19.06.2022.
//

import Foundation

final class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.listeners.forEach {
                    $0(self?.value)
                }
            }
        }
    }
    
    private var listeners: [((T?) -> Void)] = []
    
    init(_ value: T?) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
