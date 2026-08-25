//
//  Habit.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation

struct Habit: Identifiable, Codable {
    let id: UUID
    let title: String
    let subtitle: String
    var isCompleted: Bool = false

    init(id: UUID = UUID(), title: String, subtitle: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
    }
}
