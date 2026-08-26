//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import Combine
import SwiftUI

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

    private func saveHabits() {
        if let encode = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encode, forKey: Constants.key)
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
