//
//  Helpers.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import Foundation


final class Helpers{
    
    static func getWeekdayHeaders(calendar: Calendar) -> [String] {
        
        let formatter = DateFormatter()
        
        var weekdaySymbols = formatter.shortStandaloneWeekdaySymbols
        let weekdaySymbolsCount = weekdaySymbols?.count ?? 0
        
        for _ in 0 ..< (1 - calendar.firstWeekday + weekdaySymbolsCount){
            let lastObject = weekdaySymbols?.last
            weekdaySymbols?.removeLast()
            weekdaySymbols?.insert(lastObject!, at: 0)
        }
        return weekdaySymbols ?? []
    }
    
    
    static func formatDate(date: Date, calendar: Calendar) -> String {
        let formatter = dateFormatter()
        return stringFrom(date: date, formatter: formatter, calendar: calendar)
    }
    
    static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "d"
        return formatter
    }
    
    static func stringFrom(date: Date, formatter: DateFormatter, calendar: Calendar) -> String {
        if formatter.calendar != calendar {
            formatter.calendar = calendar
        }
        return formatter.string(from: date)
    }
    
    static func getMonthDayFromDate(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        return components.month! - 1
    }
    
    
    static func numberOfMonths(_ calendar: Calendar, minDate: Date, maxDate: Date) -> Int {
        calendar.dateComponents([.month], from: minDate, to: maximumDateMonthLastDay(calendar, from: maxDate)).month! + 1
    }
    
    static func maximumDateMonthLastDay(_ calendar: Calendar, from date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        components.month! += 1
        components.day = 0
        return calendar.date(from: components)!
    }
    
}

