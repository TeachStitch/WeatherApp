//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 10.06.2022.
//

import UIKit

class WeatherViewController: UIViewController {

    private enum Constants {
        static let locationBarButtonText = "Test"
        
        enum Layout {
            
        }
    }
    
    enum CellType: Int, CaseIterable {
        case mainInfo = 0
        case hourlyWeather
        case dailyWeather
    }
    
    private let viewModel: WeatherViewModelProvider?
    
    private lazy var locationBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Test123", style: .plain, target: self, action: #selector(locationButtonTapped))
        button.tintColor = .Assets.text
        
        return button
    }()
    
    private lazy var mapBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
        button.tintColor = .Assets.text
        
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = .zero
        flowLayout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(MainInfoCollectionViewCell.self)
        collectionView.register(HourlyWeatherCollectionViewCell.self)
        collectionView.register(WeekDayWeatherCollectionViewCell.self)
        collectionView.backgroundColor = .Assets.blue01
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
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
        viewModel?.onLoad()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .Assets.blue01
        view.addSubview(collectionView)
    }
    
    private func setUpNavigationBar() {
        navigationItem.setLeftBarButton(locationBarButtonItem, animated: false)
        navigationItem.setRightBarButton(mapBarButtonItem, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor.Assets.blue01
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
    
    func updateCell(_ type: CellType) {
        let indexPath = IndexPath(item: type.rawValue, section: .zero)
        switch type {
        case .mainInfo:
            collectionView.reconfigureItems(at: [indexPath])
        case .hourlyWeather:
            collectionView.reconfigureItems(at: [indexPath])
        case .dailyWeather:
            collectionView.reconfigureItems(at: [indexPath])
        }
    }
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch CellType(rawValue: indexPath.item) {
        case .mainInfo:
            guard let cell: MainInfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
            
            // MOCK
            cell.configure(with: mainInfoModel)
            
            return cell
        case .hourlyWeather:
            guard let cell: HourlyWeatherCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
            // MOCK
            cell.configure(with: hourlyModels)
            
            return cell
        case .dailyWeather:
            guard let cell: WeekDayWeatherCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
            // MOCK
            cell.configure(with: weekModels)
            
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 1, height: 1) }
        
        let numberOfVisibleCells = 3.0
        let offset = flowLayout.sectionInset.top + abs(flowLayout.sectionInset.bottom) + (flowLayout.minimumLineSpacing * (numberOfVisibleCells - 1))
        let mainInfoCellHeight = (collectionView.bounds.height - offset) / numberOfVisibleCells
        let hourlyWeatherCellHeight = (collectionView.bounds.height - mainInfoCellHeight) * 0.2
        let dailyWeatherCellHeight = collectionView.bounds.height - mainInfoCellHeight - hourlyWeatherCellHeight
        
        switch CellType(rawValue: indexPath.item) {
        case .mainInfo:
            return CGSize(width: collectionView.bounds.width, height: mainInfoCellHeight)
        case .hourlyWeather:
            return CGSize(width: collectionView.bounds.width, height: hourlyWeatherCellHeight)
        case .dailyWeather:
            return CGSize(width: collectionView.bounds.width, height: dailyWeatherCellHeight)
        case .none:
            return CGSize(width: 1, height: 1)
        }
    }
}
