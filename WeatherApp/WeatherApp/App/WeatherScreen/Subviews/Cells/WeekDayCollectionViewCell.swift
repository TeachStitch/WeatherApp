//
//  WeekDayCollectionViewCell.swift
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

class WeekDayCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let stackViewSpacing = 45.0
        
        enum Layout {
            static let stackViewEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            updateSelection()
        }
    }
    
    private lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var weatherStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            weekdayLabel,
            temperatureLabel,
            weatherStateImageView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = Constants.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
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
    
    func configure(with model: WeekDayWeatherCollectionViewCellConfigurable) {
        weekdayLabel.text = model.date.formatted(.dateTime.weekday(.abbreviated))
        weatherStateImageView.image = UIImage(systemName: "star")
        
        let currentTemperature = Measurement(value: model.currentTemperature, unit: UnitTemperature.celsius).formatted()
        let averageTemperature = Measurement(value: model.averageTemperature, unit: UnitTemperature.celsius).formatted()
        temperatureLabel.text = "\(currentTemperature)/\(averageTemperature)"
    }
    
    private func setUpSubviews() {
        contentView.addSubview(stackView)
        backgroundColor = .systemBackground
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.stackViewEdgeInsets.left),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Layout.stackViewEdgeInsets.top),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.stackViewEdgeInsets.right),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Layout.stackViewEdgeInsets.bottom)
        ])
    }
    
    private func updateSelection() {
        if isSelected {
            weekdayLabel.textColor = .systemBlue
            temperatureLabel.textColor = .systemBlue
            weatherStateImageView.tintColor = .systemBlue
        } else {
            weekdayLabel.textColor = .black
            temperatureLabel.textColor = .black
            weatherStateImageView.tintColor = .black
        }
    }
}
