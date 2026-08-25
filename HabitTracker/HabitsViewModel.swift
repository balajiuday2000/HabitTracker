//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import Combine

@Observable
class HabitsViewModel {
    enum Constants {
        static let key = "savedHabits"
    }
    var habits: [Habit] = []

    init() {
        loadHabits()
    }

    func addHabit(_ habit: Habit) {
        habits.append(habit)
        saveHabits()
    }

    func loadHabits() {
        if let data = UserDefaults.standard.data(forKey: Constants.key),
           let decodedData = try? JSONDecoder().decode([Habit].self, from: data) {
            habits = decodedData
        }
    }

    func saveHabits() {
        if let encode = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encode, forKey: Constants.key)
        }
    }
}
