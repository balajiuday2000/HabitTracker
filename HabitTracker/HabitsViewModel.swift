//
//  HabitsViewModel.swift
//  HabitTracker
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import Foundation
import Combine

class HabitsViewModel: ObservableObject {
    @Published var habits: [Habit]

    init(habits: [Habit]) {
        self.habits = habits
    }

    func addHabit(_ habit: Habit) {
        habits.append(habit)
    }
}
