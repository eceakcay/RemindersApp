//
//  EditViewController.swift
//  RemindersApp
//
//  Created by Ece Akcay on 19.09.2025.
//

import UIKit

class EditViewController: BaseReminderViewController {
    private let reminder: Reminder
    var onReminderUpdated: ((Reminder) -> Void)?

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
        actionButton.setTitle("Save", for: .normal)
        actionButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    @objc private func saveTapped() {
        guard let title = titleTextView.text, !title.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter a title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let updatedReminder = Reminder(
            id: reminder.id,
            title: title,
            description: descriptionTextView.text,
            date: datePicker.date,
            time: timePicker.date,
            isCompleted: reminder.isCompleted
        )
        onReminderUpdated?(updatedReminder)
        navigationController?.popViewController(animated: true)
    }
}
