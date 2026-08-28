//
//  HabitTests.swift
//  HabitTrackerTests
//
//  Created by Software Merchant on 8/27/26.
//

import XCTest
@testable import HabitTracker

final class HabitTests: XCTestCase {
    func testDefaultValues() {
        // Given, When
        let habit = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)
        
        // Then
        XCTAssertNotNil(habit.id)
        XCTAssertFalse(habit.isCompleted)
    }

    func testDecoding() throws {
        // Given
        let habit = Habit(title: "Wake up early", subtitle: "Early bird gets the worm!", reminderTime: nil)
        let encodedData = try JSONEncoder().encode(habit)
        let decodedData = try JSONDecoder().decode(Habit.self, from: encodedData)
        XCTAssertEqual(decodedData, habit)
    }
}
