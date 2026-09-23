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
        static let lastResetDateKey = "lastResetDay"
    }
    var habits: [Habit] = []
    let userDefaults: UserDefaults
    
    var today: Date {
        Calendar.current.startOfDay(for: Date())
    }

    // Dependency injection
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        loadHabits()
        resetAllHabitsOnNewDay()
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
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].isCompleted.toggle()
        // If completed, record streak if not already done.
        if habits[index].isCompleted {
            if !habits[index].streak.contains(today) {
                habits[index].streak.append(today)
            }
        } else {
            // Else if unchecked, remove streak.
            habits[index].streak.removeAll(where: { $0 == today })
        }
        saveHabits()
    }

    func delete(habit: Habit) {
        habits.removeAll(where: { $0 == habit })
        saveHabits()
        cancelReminder(habit: habit)
    }
    
    func resetAll() {
        for index in habits.indices {
            habits[index].isCompleted = false
            habits[index].streak.removeAll(where: { $0 == today })
        }
        saveHabits()
    }
    
    func onOrderChanged(from: IndexSet, to: Int) {
        habits.move(fromOffsets: from, toOffset: to)
        saveHabits()
    }

    func resetAllHabitsOnNewDay() {
        let today = Calendar.current.startOfDay(for: Date())
        let lastResetDate = self.userDefaults.object(forKey: Constants.lastResetDateKey) as? Date
        
        // Only proceed if last reset day is nil (first launch)
        // Or if last reset day is not the same as today.
        guard lastResetDate == nil || !Calendar.current.isDate(today, inSameDayAs: lastResetDate!) else { return }

        resetAll()
        self.userDefaults.set(today, forKey: Constants.lastResetDateKey)
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
