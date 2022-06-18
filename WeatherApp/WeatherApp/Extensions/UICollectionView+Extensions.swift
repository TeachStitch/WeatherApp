//
//  UICollectionView+Extensions.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            assertionFailure(
                "Failed to dequeue a cell with identifier \(T.identifier) matching type \(T.self). Check that you registered the cell beforehand."
            )
            return nil
        }
        
        return cell
    }
    
}
