//
//  MainInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

protocol MainInfoCollectionViewCellConfigurable {
    var date: Date { get }
    var weatherIconName: String { get }
    var temperature: Double { get }
    var humidity: Double { get }
    var windSpeed: Double { get }
}

class MainInfoCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let weatherInfoStackViewSpacing = 2.0
        static let mainStackViewSpacing = 15.0
        
        enum Layout {
            static let dateLabelEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 15, right: 8)
            static let mainStackViewEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 8, right: 15)
            static let weatherStateImageViewHeight = 60.0
            static let infoLabelHeight = 20.0
        }
    }
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.text
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var weatherInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            temperatureLabel,
            humidityLabel,
            windSpeedLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Constants.weatherInfoStackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            weatherStateImageView,
            weatherInfoStackView
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Constants.mainStackViewSpacing
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
    
    func configure(with model: MainInfoCollectionViewCellConfigurable) {
        dateLabel.text = model.date.formatted(.dateTime.weekday(.abbreviated).day(.defaultDigits).month(.wide))
        weatherStateImageView.image = UIImage(systemName: "star")
        temperatureLabel.text = Measurement(value: model.temperature, unit: UnitTemperature.celsius).formatted()
        humidityLabel.text = "\(model.humidity.formatted())%"
        windSpeedLabel.text = Measurement(value: model.windSpeed, unit: UnitSpeed.metersPerSecond).formatted()
    }
    
    private func setUpSubviews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(mainStackView)
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.dateLabelEdgeInsets.left),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Layout.dateLabelEdgeInsets.top),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.dateLabelEdgeInsets.right),
            
            humidityLabel.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor),
            windSpeedLabel.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.mainStackViewEdgeInsets.left),
            mainStackView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: Constants.Layout.mainStackViewEdgeInsets.left),
            mainStackView.heightAnchor.constraint(equalToConstant: 130),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.mainStackViewEdgeInsets.right),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Layout.mainStackViewEdgeInsets.bottom)
        ])
    }
    
}
