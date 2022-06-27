//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 20.06.2022.
//

import UIKit
import MapKit

protocol MapViewControllerDelegate: AnyObject {
    func didChoseCity(with coordinates: CLLocationCoordinate2D)
}

class MapViewController: UIViewController {
    
    private enum Constants {
        static let searchBarPlaceholder = "Search for a City"
    }
    
    private let viewModel: MapViewModelProvider?
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsController())
        controller.searchBar.placeholder = Constants.searchBarPlaceholder
        controller.searchBar.searchBarStyle = .default
        controller.searchResultsUpdater = self
        
        return controller
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(viewModel: MapViewModelProvider?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpSubviews()
        setUpAutoLayoutConstraints()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
    }
    
    private func setUpAutoLayoutConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpNavigationBar() {
        navigationItem.searchController = searchController
    }
}

extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count > 3 else { return }
        let resultsController = searchController.searchResultsController as? SearchResultsController
        
//        resultsController?.viewModel
    }
}
