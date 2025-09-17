//
//  ListViewController.swift
//  RemindersApp
//
//  Created by Ece Akcay on 17.09.2025.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
    
    private let viewModel = ListViewModel()
    private let tableView = UITableView()
    private let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
    }
    
    private func setupUI() {
        title = "Reminders"
        view.backgroundColor = .white
        
        
    }
    
    private func setupTableView() {
        
    }
    
    private func setupBindings() {
        
    }
}
