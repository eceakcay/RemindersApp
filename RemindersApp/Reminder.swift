//
//  Reminder.swift
//  RemindersApp
//
//  Created by Ece Akcay on 16.09.2025.
//

import Foundation

//Veriyi temsil eden model
//Codable sayesinde modelimizi JSON gibi formatlara kolayca çevirip UserDefaults’ta saklayabiliriz
//Identifiable protokolü, her Reminder’ın benzersiz bir id alanına sahip olduğunu garanti eder
struct Reminder : Codable, Identifiable {
    let id : UUID
    var title : String
    var description : String
    var date : Date
    var time : Date
    var isCompleted : Bool
    
    init(id : UUID = UUID(), title : String , description: String? = nil, date : Date , time : Date , isCompleted : Bool = false)
    {
        self.id = id
        self.title = title
        self.description = description ?? ""
        self.date = date
        self.time = time
        self.isCompleted = isCompleted
    }
}
