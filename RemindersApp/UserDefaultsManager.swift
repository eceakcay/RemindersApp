//
//  UserDefaultsManager.swift
//  RemindersApp
//
//  Created by Ece Akcay on 16.09.2025.
//

import Foundation

//Bu sınıf, Reminder dizisini JSON formatında UserDefaults’a kaydeder ve geri alır
//Reminder’ları cihazda yerel olarak saklıyoruz
class UserDefaultsManager {
    private let remindersKey = "reminders"
    
    func saveReminders(_ reminders: [Reminder]) {
        do {
            let data = try JSONEncoder().encode(reminders)
            UserDefaults.standard.set(data, forKey: remindersKey)
        } catch  {
            print("Error saving reminders: \(error)")
        }
    }
    
    func fetchReminders() -> [Reminder]
    {
        guard let data = UserDefaults.standard.data(forKey: remindersKey) else { return [] }
        do {
            let reminders = try JSONDecoder().decode([Reminder].self, from: data)
            return reminders
        } catch  {
            print("Error fetching reminders : \(error)")
            return []
        }
    }
}
