//
//  SearchResultsController.swift
//  WeatherApp
//
//  Created by Arsenii Kovalenko on 26.06.2022.
//

import Foundation
import UIKit

class SearchResultsController: UITableViewController {
    
    var viewModel: SearchResultsViewModelProvider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .yellow
    }
}
