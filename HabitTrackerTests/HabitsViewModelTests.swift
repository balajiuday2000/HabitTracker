//
//  HabitTrackerTests.swift
//  HabitTrackerTests
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import XCTest
@testable import HabitTracker

final class HabitsViewModelTests: XCTestCase {
    var viewModel: HabitsViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        let userDefaults = UserDefaults(suiteName: "habit.tracker.tests")!
        userDefaults.removePersistentDomain(forName: "habit.tracker.tests")
        viewModel = HabitsViewModel(userDefaults: userDefaults)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        try super.tearDownWithError()
    }

    func testAddHabit() {
        // Given
        let habit = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)

        // When
        viewModel.addHabit(habit)

        // Then
        XCTAssertEqual(viewModel.habits.count, 1)
        XCTAssertNotNil(viewModel.userDefaults.data(forKey: HabitsViewModel.Constants.key))
    }
    
    func testLoadHabits() {
        // Given
        let habit = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)
        viewModel.addHabit(habit) // Save to storage
        viewModel.habits = [] // Reset to simulate launch
        
        // When
        viewModel.loadHabits()
        
        // Then
        XCTAssertEqual(viewModel.habits.count, 1)
        XCTAssertEqual(viewModel.habits.first?.title, "Wake up early")
        XCTAssertEqual(viewModel.habits.first?.subtitle, "Early bird gets the worm!")
        XCTAssertNil(viewModel.habits.first?.reminderTime)
    }
    
    func testOnToggle() {
        // Given
        let habit = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)
        viewModel.addHabit(habit)
        
        // When
        viewModel.onToggle(habit: habit)
        
        // Then
        XCTAssertEqual(viewModel.habits.first?.isCompleted, true)
        
        // When
        viewModel.onToggle(habit: habit)
        
        // Then
        XCTAssertEqual(viewModel.habits.first?.isCompleted, false)
    }

    func testDelete() {
        // Given
        let habit1 = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)
        let habit2 = Habit(title: "Water plants", subtitle: "Take care of the little ones!", reminderTime: nil)
        viewModel.addHabit(habit1)
        viewModel.addHabit(habit2)
        
        // When
        viewModel.delete(habit: habit2)
        
        // Then
        XCTAssertEqual(viewModel.habits.count, 1)
        XCTAssertEqual(viewModel.habits.first, habit1)
    }
    
    func testResetAll() {
        // Given
        let habit1 = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)
        let habit2 = Habit(title: "Water plants", subtitle: "Take care of the little ones!", reminderTime: nil)
        viewModel.addHabit(habit1)
        viewModel.addHabit(habit2)
        viewModel.onToggle(habit: habit1)
        viewModel.onToggle(habit: habit2)
        
        // When
        viewModel.resetAll()
        
        // Then
        XCTAssertEqual(viewModel.habits[0].isCompleted, false)
        XCTAssertEqual(viewModel.habits[1].isCompleted, false)
    }
    
    func testOnOrderChanged() {
        // Given
        let habit1 = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)
        let habit2 = Habit(title: "Water plants", subtitle: "Take care of the little ones!", reminderTime: nil)
        viewModel.addHabit(habit1)
        viewModel.addHabit(habit2)
        
        // When
        viewModel.onOrderChanged(from: IndexSet(integer: 1), to: 0)
        
        // Then
        XCTAssertEqual(viewModel.habits[0], habit2)
        XCTAssertEqual(viewModel.habits[1], habit1)
    }
}
