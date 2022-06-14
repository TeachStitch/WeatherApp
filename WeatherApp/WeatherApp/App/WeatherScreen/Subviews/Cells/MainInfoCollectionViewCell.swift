//
//  MainInfoCollectionViewCell.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 13.06.2022.
//

import UIKit

class MainInfoCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let weatherInfoStackViewSpacing = 2.0
        static let mainStackViewSpacing = 15.0
        
        enum Layout {
            static let dateLabelEndgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 15, right: 8)
            static let mainStackViewBottomIndent = 8.0
            static let weatherStateImageViewHeight = 60.0
            static let infoLabelHeight = 20.0
        }
    }
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.white
        label.text = "Mon, 20 July"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.white
        label.textAlignment = .center
        label.text = "27"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.white
        label.textAlignment = .center
        label.text = "57%"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Assets.white
        label.textAlignment = .center
        label.text = "27 mps"
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
//        stackView.distribution = .equalSpacing
        stackView.contentMode = .center
        stackView.spacing = Constants.mainStackViewSpacing
//        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
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
    
    func configure(with viewModel: String) {
        print(#function)
    }
    
    private func setUpSubviews() {
        backgroundColor = .black
        contentView.addSubview(dateLabel)
        contentView.addSubview(mainStackView)
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.Layout.dateLabelEndgeInsets.left),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.Layout.dateLabelEndgeInsets.top),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.Layout.dateLabelEndgeInsets.right),
            
            weatherStateImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.weatherStateImageViewHeight),
            
            temperatureLabel.heightAnchor.constraint(equalToConstant: Constants.Layout.infoLabelHeight),
            humidityLabel.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor),
            windSpeedLabel.heightAnchor.constraint(equalTo: temperatureLabel.heightAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Layout.mainStackViewBottomIndent)
        ])
    }
    
}
