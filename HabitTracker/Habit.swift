//
//  Habit.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation

struct Habit: Identifiable, Codable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    var isCompleted: Bool = false
    var reminderTime: Date? = nil

    init(id: UUID = UUID(), title: String, subtitle: String, reminderTime: Date?) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.reminderTime = reminderTime
    }
}
