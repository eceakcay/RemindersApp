//
//  CreateViewController.swift
//  RemindersApp
//
//  Created by Ece Akcay on 19.09.2025.
//

import Foundation
import UIKit

//Kullanıcı başlık, açıklama, tarih ve saat girer. “Done” butonu ile veri closure aracılığıyla ListViewController’a gönderilir.
class CreateViewController: BaseReminderViewController {
    var onReminderCreated: ((Reminder) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.setTitle("Done", for: .normal)
        actionButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }
    
    @objc private func doneTapped() {
        guard let title = titleTextView.text, !title.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please enter a title", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        let reminder = Reminder(
            title: title,
            description: descriptionTextView.text ,
            date: datePicker.date,
            time: timePicker.date
        )
        onReminderCreated?(reminder)
        navigationController?.popViewController(animated: true)
    }
}
