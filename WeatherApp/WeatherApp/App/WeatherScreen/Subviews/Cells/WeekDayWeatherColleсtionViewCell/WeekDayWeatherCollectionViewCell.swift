//
//  WeekDayWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 14.06.2022.
//

import UIKit

protocol WeekDayWeatherCollectionViewCellConfigurable {
    var date: Date { get }
    var currentTemperature: Double { get }
    var averageTemperature: Double { get }
    var weatherIconName: String { get }
}

class WeekDayWeatherCollectionViewCell: UICollectionViewCell {
    
    private var models = [WeekDayWeatherCollectionViewCellConfigurable]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SecondaryWeekDayCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
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
    
    func configure(with models: [WeekDayWeatherCollectionViewCellConfigurable]) {
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

extension WeekDayWeatherCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: SecondaryWeekDayCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
        cell.configure(with: models[indexPath.item])
        
        return cell
    }
}

extension WeekDayWeatherCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 1, height: 1) }
        
        let numberOfVisibleCells = 6.0
        let offset = flowLayout.sectionInset.top + abs(flowLayout.sectionInset.bottom) + (flowLayout.minimumInteritemSpacing * (numberOfVisibleCells - 1))
        let height = (collectionView.bounds.height - offset) / numberOfVisibleCells
        return CGSize(width: collectionView.bounds.width, height: height)
    }
}
