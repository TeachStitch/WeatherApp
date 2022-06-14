//
//  UITableView+Extensions.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

extension UITableView {
    
    final func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    final func register<T: UITableViewCell>(_ cellTypes: [T.Type]) {
        cellTypes.forEach { register($0) }
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            assertionFailure(
                "Failed to dequeue a cell with identifier \(T.identifier) matching type \(T.self). Check that you registered the cell beforehand."
            )
            return nil
        }
                
        return cell
    }
}
