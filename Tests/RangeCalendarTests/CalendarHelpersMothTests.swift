//
//  CalendarHelpersMothTests.swift
//  
//
//  Created by Bogdan Zykov on 12.04.2023.
//

import XCTest
@testable import RangeCalendar

final class CalendarHelpersMothTests: XCTestCase {
    
    var calendar: Calendar!
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        calendar = Calendar.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    }
    
    func testNumberOfMonths() {
        let minDate = dateFormatter.date(from: "2021-01-01 00:00:00 +0000")!
        let maxDate = dateFormatter.date(from: "2021-12-31 23:59:59 +0000")!
        
        let numberOfMonths = Helpers.numberOfMonths(calendar, minDate: minDate, maxDate: maxDate)
        
        XCTAssertEqual(numberOfMonths, 13, "Expected 12 months between the dates.")
    }
    
    func testNumberOfMonthsWhenSameDate() {
        let date = Date()
        
        let numberOfMonths = Helpers.numberOfMonths(calendar, minDate: date, maxDate: date)
        
        XCTAssertEqual(numberOfMonths, 1, "Expected 1 month for the same date.")
    }
    
    func testNumberOfMonthsWhenMaxDateBeforeMinDate() {
        let minDate = dateFormatter.date(from: "2022-01-01 00:00:00 +0000")!
        let maxDate = dateFormatter.date(from: "2021-12-31 23:59:59 +0000")!
        
        let numberOfMonths = Helpers.numberOfMonths(calendar, minDate: minDate, maxDate: maxDate)
        
        XCTAssertEqual(numberOfMonths, 1, "Expected 0 months when max date is before min date.")
    }
    
    // MARK: - maximumDateMonthLastDay tests
    
    func testMaximumDateMonthLastDay() {
        let date = dateFormatter.date(from: "2021-10-15 13:00:00 +0000")!
        let expectedDate = dateFormatter.date(from: "2021-10-30 21:00:00 +0000")!
        
        let maxDate = Helpers.maximumDateMonthLastDay(calendar, from: date)
        
        XCTAssertEqual(maxDate, expectedDate, "Expected last day of the month for October 2021.")
    }
    
    func testMaximumDateMonthLastDayWhenLastDay() {
        let date = dateFormatter.date(from: "2021-12-31 13:00:00 +0000")!
        let expectedDate = dateFormatter.date(from: "2021-12-30 21:00:00 +0000")!
        
        let maxDate = Helpers.maximumDateMonthLastDay(calendar, from: date)
        
        XCTAssertEqual(maxDate, expectedDate, "Expected last day of December 2021.")
    }
    
}
