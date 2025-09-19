//
//  DetailViewController.swift
//  RemindersApp
//
//  Created by Ece Akcay on 19.09.2025.
//

import Foundation
import UIKit

class DetailViewController: BaseReminderViewController {
    private let reminder: Reminder
    var onReminderUpdated: ((Reminder) -> Void)? // Bu closure'ı ekleyin

    init(reminder: Reminder) {
        self.reminder = reminder
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextView.text = reminder.title
        descriptionTextView.text = reminder.description
        datePicker.date = reminder.date
        timePicker.date = reminder.time
        
        // TextView'ları readonly yapın
        titleTextView.isUserInteractionEnabled = false
        descriptionTextView.isUserInteractionEnabled = false
        datePicker.isEnabled = false
        timePicker.isEnabled = false
        
        actionButton.setTitle("Edit", for: .normal)
        actionButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
    }

    @objc private func editTapped() {
        let editVC = EditViewController(reminder: reminder)
        editVC.onReminderUpdated = onReminderUpdated // Closure'ı Edit'e iletin
        navigationController?.pushViewController(editVC, animated: true)
    }
}
