//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 10.06.2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    private enum Constants {
        static let locationBarButtonText = "Test"
        
        enum Layout {
            
        }
    }
    
    enum SectionKind: Int, CaseIterable {
        case mainInfo = 0
        case hourlyWeather
        case dailyWeather
        
        var itemCount: Int {
            switch self {
            case .mainInfo:
                return 1
            case .hourlyWeather:
                return hourlyModels.count
            case .dailyWeather:
                return weekModels.count
            }
        }
    }
    
    private let viewModel: WeatherViewModelProvider?
    
    private lazy var locationBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Constants.locationBarButtonText, style: .plain, target: self, action: #selector(locationButtonTapped))
//        button.tintColor = .Assets.text
        
        return button
    }()
    
    private lazy var mapBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
//        button.tintColor = .Assets.text
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Test")
        collectionView.register(MainInfoCollectionViewCell.self)
        collectionView.register(HourlyWeatherCollectionViewCell.self)
        collectionView.register(WeekDayCollectionViewCell.self)
        collectionView.backgroundColor = .Assets.blue01
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
//        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    init(viewModel: WeatherViewModelProvider?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpNavigationBar()
        setUpAutoLayoutConstraints()
        viewModel?.hourlyWeatherModel.bind { [weak self] model in
            DispatchQueue.main.async {
                self?.locationBarButtonItem.title = model?.cityName
                self?.collectionView.reloadData()
            }
        }
        
        viewModel?.onLoad()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            print(self.viewModel?.hourlyWeatherModel?.cityName)
//            print(self.viewModel?.hourlyWeatherModel?.hourlyForecasts.first?.date)
//        }
    }
    
    private func setUpSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setUpNavigationBar() {
        navigationItem.setLeftBarButton(locationBarButtonItem, animated: false)
        navigationItem.setRightBarButton(mapBarButtonItem, animated: false)
//        navigationController?.navigationBar.backgroundColor = UIColor.Assets.blue01
//        navigationController?.navigationBar.tintColor = .Assets.blue01
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            switch SectionKind(rawValue: sectionIndex) {
            case .mainInfo:
                return self?.mainSectionLayout()
            case .hourlyWeather:
                return self?.hourlySectionLayout()
            case .dailyWeather:
                return self?.dailySectionLayout()
            case .none:
                return nil
            }
        }
        
        return layout
    }
    
    private func mainSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(0.3)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func hourlySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.25),
            heightDimension: .fractionalHeight(0.2)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    private func dailySectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    @objc private func mapButtonTapped() {
        viewModel?.mapTapped()
    }
    
    @objc private func locationButtonTapped() {
        viewModel?.locationTapped()
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
    func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func updateView() {
        locationBarButtonItem.title = viewModel?.hourlyWeatherModel.value?.cityName
        collectionView.reloadData()
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionKind(rawValue: section) {
        case .mainInfo:
            return 1
        case .hourlyWeather:
            return viewModel?.hourlyWeatherModel.value?.hourlyForecasts.count ?? 0
        case .dailyWeather:
            return viewModel?.hourlyWeatherModel.value?.hourlyForecasts.count ?? 0
        case .none:
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionKind.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionKind(rawValue: indexPath.section) {
        case .mainInfo:
            guard
                let cell: MainInfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath),
                let models = viewModel?.hourlyWeatherModel.value?.hourlyForecasts as? [ExtendedWeatherInfoConfiguration]
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: MainInfoCollectionViewCell.identifier, for: indexPath)
            }
            cell.configure(with: models[indexPath.item])

            return cell
        case .hourlyWeather:
            guard
                let cell: HourlyWeatherCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath),
                let models = viewModel?.hourlyWeatherModel.value?.hourlyForecasts as? [BaseWeatherInfoConfiguration]
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath)
            }
            cell.configure(with: models[indexPath.item])

            return cell
        case .dailyWeather:
            guard
                let cell: WeekDayCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath),
                let models = viewModel?.hourlyWeatherModel.value?.hourlyForecasts as? [ExtendedWeatherInfoConfiguration]
            else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.identifier, for: indexPath)
            }
            cell.configure(with: models[indexPath.item])

            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
}
