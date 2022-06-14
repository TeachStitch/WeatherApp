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
    
    private enum CellType: Int, CaseIterable {
        case mainInfo = 0
        case hourlyWeather
        case dailyWeather
    }
    
    private let viewModel: WeatherViewModelProvider?
    
    private lazy var locationBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Test123", style: .plain, target: self, action: #selector(locationButtonTapped))
        button.tintColor = .Assets.white
        
        return button
    }()
    
    private lazy var mapBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(mapButtonTapped))
        button.tintColor = .Assets.white
        
        return button
    }()
    
    private lazy var listView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.setCollectionViewLayout(UICollectionViewFlowLayout(), animated: false)
        collectionView.register(MainInfoCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        view.backgroundColor = .Assets.blured
        view.addSubview(listView)
    }
    
    private func setUpNavigationBar() {
        navigationItem.setLeftBarButton(locationBarButtonItem, animated: false)
        navigationItem.setRightBarButton(mapBarButtonItem, animated: false)
        navigationController?.navigationBar.backgroundColor = UIColor.Assets.blue01
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            listView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainInfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) else { return UICollectionViewCell() }
        
//        cell.backgroundColor = .brown
        
        // MARK: Provide layout and cell classes
//        switch CellType(rawValue: indexPath.item) {
//        case .mainInfo:
//            break
//        case .hourlyWeather:
//            break
//        default:
//            break
//        }
        
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: 1, height: 1) }
        
        return CGSize(width: collectionView.bounds.width, height: 100)
    }
}
