import XCTest
@testable import RangeCalendar

final class RangeCalendarTests: XCTestCase {

    
    //MARK: - WeekdayHeaders
    
    func testGetWeekdayHeadersReturnsCorrectSymbols() {
        let calendar = Calendar(identifier: .gregorian)
        let headers = Helpers.getWeekdayHeaders(calendar: calendar)
        XCTAssertEqual(headers, ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"])
    }

    func testGetWeekdayHeadersHandlesDifferentFirstWeekday() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        let headers = Helpers.getWeekdayHeaders(calendar: calendar)
        XCTAssertEqual(headers, ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
    }

    func testGetWeekdayHeadersReturnsEmptyArrayForLocale() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "fr_FR")
        let headers = Helpers.getWeekdayHeaders(calendar: calendar)
        XCTAssertEqual(headers, ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
    }
    
    
    //MARK: - Date format tests
    
    func testFormatDateForUsingFormat() {
        let date = Date()
        let calendar = Calendar.current
        let formattedDate = Helpers.formatDate(date: date, calendar: calendar)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let expectedDate = dateFormatter.string(from: date)
        XCTAssertEqual(formattedDate, expectedDate)
    }
    
    func testFormatDateForDateFormat() {
        let date = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "dd/MM/yyyy"
        let expectedDate = formatter.string(from: date)
        let formattedDate = Helpers.stringFrom(date: date, formatter: formatter, calendar: calendar)
        XCTAssertEqual(formattedDate, expectedDate)
    }
    
    func testFormatDateForGregorianCalendar() {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        let expectedDate = formatter.string(from: date)
        let formattedDate = Helpers.stringFrom(date: date, formatter: formatter, calendar: calendar)
        XCTAssertEqual(formattedDate, expectedDate)
    }
    
    func testDateFormaterShouldBeFormatD() {
        let formatter = Helpers.dateFormatter()
        XCTAssertEqual(formatter.dateFormat, "d")
    }
    
    //MARK: - Month From Date
    
    func testGetMonthDayFromDateShoudBeCorrectDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

        let date = dateFormatter.date(from: "2021-10-15 13:00:00 +0000")!
        let month = Helpers.getMonthDayFromDate(date: date)

        XCTAssertEqual(month, 9)
    }
    
    func testGetMonthDayFromDateEmptyDate() {
        let date = Date()
        let month = Helpers.getMonthDayFromDate(date: date)

        XCTAssertNotNil(month, "Month should not be nil for a valid date.")
    }

    
}
