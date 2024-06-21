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


    func testWeekdaySymbol() {
        let calendar = Calendar.current
        var components = DateComponents(
            calendar: calendar,
            year: 2024,
            month: 6,
            day: 16
        ) // Start with a known Sunday

            // Define a set of known dates and their expected weekday symbols
            let testCases = [
                ("2024/06/16", "Sun"),
                ("2024/06/17", "Mon"),
                ("2024/06/18", "Tue"),
                ("2024/06/19", "Wed"),
                ("2024/06/20", "Thu"),
                ("2024/06/21", "Fri"),
                ("2024/06/22", "Sat"),
                ("2024/06/23", "Sun")
            ]

            for (dateString, expectedWeekday) in testCases {
                let date = calendar.date(from: components)!
                let weekdaySymbol = CalendarCustomizeHelper.weekdaySymbol(for: date)
                XCTAssertEqual(weekdaySymbol, expectedWeekday, "Failed for date: \(dateString)")
                components.day! += 1
            }
        }

    func testDateDisplayText() {
            let calendar = Calendar.current
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd"

            // Test Case 1: Today's date
            let today = Date()
            XCTAssertEqual(CalendarCustomizeHelper.dateDisplayText(for: today), "Today", "Failed for today's date")

            // Test Case 2: A specific past date (not today)
            var components = DateComponents(
                calendar: calendar,
                year: 2024,
                month: 6,
                day: 20
            )
            let specificDate = calendar.date(from: components)!
            XCTAssertEqual(CalendarCustomizeHelper.dateDisplayText(for: specificDate), "20 Jun", "Failed for date: 2024/06/20")

            // Test Case 3: Another specific past date (not today)
            components.year = 2024
            components.month = 12
            components.day = 25
            let anotherDate = calendar.date(from: components)!
            XCTAssertEqual(CalendarCustomizeHelper.dateDisplayText(for: anotherDate), "25 Dec", "Failed for date: 2024/12/25")

            // Test Case 4: A specific future date (not today)
            components.year = 2025
            components.month = 1
            components.day = 1
            let futureDate = calendar.date(from: components)!
            XCTAssertEqual(CalendarCustomizeHelper.dateDisplayText(for: futureDate), "1 Jan", "Failed for date: 2025/01/01")
        }
}
