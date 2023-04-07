import XCTest
@testable import RangeCalendar

final class RangeCalendarTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Helpers.getWeekdayHeaders(calendar: .current), ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"])
        XCTAssertEqual(Helpers.formatDate(date: Date().addingTimeInterval(60*60*24), calendar: .current), "8")
    }
}
