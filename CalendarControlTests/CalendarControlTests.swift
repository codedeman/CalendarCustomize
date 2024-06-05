//
//  CalendarControlTests.swift
//  CalendarControlTests
//
//  Created by Kevin on 6/5/24.
//

import XCTest
@testable import CalendarControl

final class CalendarControlTests: XCTestCase {

    func testGetCalendarGrid() {
         // Create a reference date for testing
         let date = Date() // Use any specific date for testing

         // Call the method to get the calendar grid
         let calendarGrid = CalendarHelper.getCalendarGrid(for: date)

         // Assert that the grid is not empty and has the expected structure
         XCTAssertFalse(calendarGrid.isEmpty, "Calendar grid should not be empty")
         XCTAssertEqual(calendarGrid.count, 6, "Calendar grid should have 6 rows")
         XCTAssertEqual(calendarGrid[0].count, 7, "First row of calendar grid should have 7 elements")
         // Add more assertions as needed based on your expected grid structure
     }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
