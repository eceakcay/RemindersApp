//
//  ListViewModel.swift
//  RemindersApp
//
//  Created by Ece Akcay on 16.09.2025.
//

import Foundation

class ListViewModel {
    private var reminders: [Reminder] = []
    private let userDefaultsManager = UserDefaultsManager()
    var onRemindersUpdated: (() -> Void)?
    
    init(){
        reminders = userDefaultsManager.fetchReminders()
    }
    
    var numberOfReminders: Int {
        return reminders.count
    }
    
    func reminder(at index: Int) -> Reminder {
        return reminders[index]
    }
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
        userDefaultsManager.saveReminders(reminders)
        onRemindersUpdated?()
    }
    
    func updateReminder(_ reminder: Reminder, at index: Int) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id })
        {
            reminders[index] = reminder
            userDefaultsManager.saveReminders(reminders)
            onRemindersUpdated?()
        }
    }
    
    func toggleCompletion(at index: Int) {
            reminders[index].isCompleted.toggle()
            userDefaultsManager.saveReminders(reminders)
            onRemindersUpdated?()
        }

        func deleteReminder(at index: Int) {
            reminders.remove(at: index)
            userDefaultsManager.saveReminders(reminders)
            onRemindersUpdated?()
        }
}
