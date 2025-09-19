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
    private let dateFormatter: DateFormatter = {
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReminderCell")
    }

    private func setupBindings() {
        viewModel.onRemindersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    @objc private func addTapped() {
        let createVC = CreateViewController()
        createVC.onReminderCreated = { [weak self] reminder in
            self?.viewModel.addReminder(reminder)
        }
        navigationController?.pushViewController(createVC, animated: true)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfReminders
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        let reminder = viewModel.reminder(at: indexPath.row)
        let dateTime = dateFormatter.string(from: reminder.date) + " " + dateFormatter.string(from: reminder.time)
        cell.textLabel?.text = "\(reminder.title) - \(dateTime)"
        cell.accessoryType = reminder.isCompleted ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idx = indexPath.row
        let reminder = viewModel.reminder(at: idx)
        let detailVC = DetailViewController(reminder: reminder)

        detailVC.onReminderUpdated = { [weak self] updated in
            // İmzana göre birini kullan:
            self?.viewModel.updateReminder(updated, at: idx)
            // veya
            // self?.viewModel.updateReminder(at: idx, with: updated)

            // UI’ı satır bazında tazelemek istersen:
            DispatchQueue.main.async {
                self?.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .automatic)
            }
        }

        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.viewModel.deleteReminder(at: indexPath.row)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { [weak self] _, _, completion in
            self?.viewModel.toggleCompletion(at: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        completeAction.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
}
