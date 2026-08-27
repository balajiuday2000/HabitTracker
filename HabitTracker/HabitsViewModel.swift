//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import Combine
import SwiftUI
import UserNotifications

@Observable
class HabitsViewModel {
    enum Constants {
        static let key = "savedHabits"
    }
    var habits: [Habit] = []
    let userDefaults: UserDefaults

    // Dependency injection
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        loadHabits()
    }

    func addHabit(_ habit: Habit) {
        habits.append(habit)
        saveHabits()
        scheduleReminder(habit: habit)
        
    }

    func loadHabits() {
        if let data = self.userDefaults.data(forKey: Constants.key),
           let decodedData = try? JSONDecoder().decode([Habit].self, from: data) {
            habits = decodedData
        }
    }

    private func saveHabits() {
        if let encode = try? JSONEncoder().encode(habits) {
            self.userDefaults.set(encode, forKey: Constants.key)
        }
    }

    func onToggle(habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index].isCompleted.toggle()
            saveHabits()
        }
    }

    func delete(habit: Habit) {
        habits.removeAll(where: { $0 == habit })
        saveHabits()
        cancelReminder(habit: habit)
    }
    
    func resetAll() {
        for index in habits.indices {
            habits[index].isCompleted = false
        }
        saveHabits()
    }
    
    func onOrderChanged(from: IndexSet, to: Int) {
        habits.move(fromOffsets: from, toOffset: to)
        saveHabits()
    }
}

// MARK: UserNotifications

extension HabitsViewModel {
    func scheduleReminder(habit: Habit) {
        guard let reminderTime = habit.reminderTime else { return }
        
        // Content of reminder
        let content = UNMutableNotificationContent()
        content.title = habit.title
        content.body = habit.subtitle
        content.sound = .default
        
        // Trigger
        let components = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        // Request
        let request = UNNotificationRequest(
            identifier: habit.id.uuidString,
            content: content,
            trigger: trigger
        )

        // Add request
        UNUserNotificationCenter.current().add(request) { _ in }
    }
    
    func cancelReminder(habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [habit.id.uuidString])
    }
}
