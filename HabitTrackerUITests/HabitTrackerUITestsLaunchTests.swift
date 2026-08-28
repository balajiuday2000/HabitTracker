//
//  HabitTrackerUITestsLaunchTests.swift
//  HabitTrackerUITests
//
//  Created by Balaji Udayakumar on 8/25/26.
//

import XCTest

final class HabitTrackerUITestsLaunchTests: XCTestCase {
    var app: XCUIApplication!
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    @MainActor
    func testAddingANewHabitAndToggling() {
        // Tap to add new habit
        app.buttons["addHabitButton"].tap()
        
        // Enter habit details
        let titleTextField = app.textFields["habitTitleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Wake up early")
        
        let subTitleTextField = app.textFields["habitSubtitleTextField"]
        subTitleTextField.tap()
        subTitleTextField.typeText("Early bird gets the worm!")
        
        // Tap to save habit
        app.buttons["saveHabbitButton"].tap()
        
        // Check for new habit
        XCTAssertTrue(app.staticTexts["Wake up early"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Early bird gets the worm!"].waitForExistence(timeout: 2))
    }
}
