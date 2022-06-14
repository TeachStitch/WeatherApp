//
//  WeekDayWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 14.06.2022.
//

import UIKit

class WeekDayWeatherCollectionViewCell: UICollectionViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SecondaryWeekDayCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        setUpAutoLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubviews()
        setUpAutoLayoutConstraints()
    }
    
    private func setUpSubviews() {
        contentView.addSubview(collectionView)
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension WeekDayWeatherCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SecondaryWeekDayCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
        
        return cell
    }
}

extension WeekDayWeatherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 1, height: 1) }
        
        let numberOfCellsPerRow = 6.0
        let offset = flowLayout.sectionInset.top + abs(flowLayout.sectionInset.bottom) + (flowLayout.minimumInteritemSpacing * (numberOfCellsPerRow - 1))
        let height = (collectionView.bounds.height - offset) / numberOfCellsPerRow
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}
