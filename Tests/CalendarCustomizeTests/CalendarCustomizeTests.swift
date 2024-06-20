import XCTest
@testable import CalendarCustomize

final class CalendarCustomizeTests: XCTestCase {

    func testGetCalendarGrid() {
        // Create a reference date for testing
        let date = Date() // Use any specific date for testing

        // Call the method to get the calendar grid
        let calendarGrid = CalendarCustomizeHelper.getCalendarGrid(for: date)

        // Assert that the grid is not empty and has the expected structure
        XCTAssertFalse(calendarGrid.isEmpty, "Calendar grid should not be empty")
        XCTAssertEqual(calendarGrid.count, 6, "Calendar grid should have 6 rows")
        XCTAssertEqual(calendarGrid[0].count, 7, "First row of calendar grid should have 7 elements")
        // Add more assertions as needed based on your expected grid structure
    }
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
}
