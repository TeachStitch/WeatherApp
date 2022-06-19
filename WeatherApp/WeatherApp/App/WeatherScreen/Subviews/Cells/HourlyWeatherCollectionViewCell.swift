//
//  HourlyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 14.06.2022.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let stackViewSpacing = 5.0
        static let timeLabelCustomSpacing = 10.0
        
        enum Layout {
            static let stackViewEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            static let timeLabelHeight = 25.0
            static let weatherImageHeight = 15.0
        }
    }
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.text
        label.textAlignment = .center
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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            timeLabel,
            weatherStateImageView,
            temperatureLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        stackView.distribution = .fillProportionally
//        stackView.setCustomSpacing(Constants.timeLabelCustomSpacing, after: timeLabel)
        
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
    
    func configure(with model: BaseWeatherInfoConfiguration) {
        timeLabel.text = model.date.formatted(.dateTime.hour())
        weatherStateImageView.image = UIImage(named: model.iconName)
        temperatureLabel.text = Measurement(value: model.temperature, unit: UnitTemperature.celsius).formatted()
    }
    
    private func setUpSubviews() {
        contentView.addSubview(stackView)
        backgroundColor = .Assets.blue02
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.stackViewEdgeInsets.left),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Layout.stackViewEdgeInsets.top),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.stackViewEdgeInsets.right),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Layout.stackViewEdgeInsets.bottom)
            
//            timeLabel.heightAnchor.constraint(equalToConstant: Constants.Layout.timeLabelHeight),
//            weatherStateImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.weatherImageHeight),
//            weatherStateImageView.widthAnchor.constraint(equalTo: weatherStateImageView.heightAnchor),
//            timeLabel.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.Layout.timeLabelHeight),
//            temperatureLabel.heightAnchor.constraint(equalTo: timeLabel.heightAnchor)
        ])
    }
}
