import XCTest
@testable import CalendarUI

final class CalendarUITests: XCTestCase {

    func testGetCalendarGrid() {
        // Create a reference date for testing
        let date = Date() // Use any specific date for testing

        // Call the method to get the calendar grid
        let calendarGrid = CalendarHelper.getCalendarGrid(for: date)
        
        // Assert that the grid is not empty and has the expected structure
        XCTAssertFalse(calendarGrid.isEmpty, "Calendar grid should not be empty")
        XCTAssertEqual(calendarGrid.count, 5, "Calendar grid should have 6 rows")
        XCTAssertEqual(calendarGrid[0].count, 7, "First row of calendar grid should have 7 elements")
        // Add more assertions as needed based on your expected grid structure
    }


}
