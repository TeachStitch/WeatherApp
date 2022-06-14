//
//  HourlyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 14.06.2022.
//

import UIKit

protocol HourlyWeatherCollectionViewCellConfigurable {
    var date: Date { get }
    var temperature: Double { get }
    var weatherIconName: String { get }
}

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    private var models = [HourlyWeatherCollectionViewCellConfigurable]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SecondaryHourlyWeatherCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .Assets.blue02
        collectionView.showsHorizontalScrollIndicator = false
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
    
    func configure(with models: [HourlyWeatherCollectionViewCellConfigurable]) {
        self.models = models
//        collectionView.reloadData()
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

extension HourlyWeatherCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SecondaryHourlyWeatherCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: models[indexPath.item])
        
        return cell
    }
}

extension HourlyWeatherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 1, height: 1) }
        
        let numberOfVisibleCells = 4.0
        let offset = flowLayout.sectionInset.left + abs(flowLayout.sectionInset.right) + (flowLayout.minimumInteritemSpacing * (numberOfVisibleCells - 1))
        
        let width = (collectionView.bounds.width - offset) / numberOfVisibleCells
        return CGSize(width: width, height: collectionView.bounds.height)
    }
}
