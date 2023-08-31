//
//  RCManager.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import Foundation
import SwiftUI

@available(macOS 10.15, *)
public class RCManager: ObservableObject {

    @Published public var selectedDate: Date! = nil
    @Published public var startDate: Date! = nil
    @Published public var endDate: Date! = nil
    
    var calendar = Calendar.current
    var minimumDate: Date = Date()
    var maximumDate: Date = Date()
    var disabledDates:  [Date] = []
    var disabledAfterDate: Date?
    
    public var colors = ColorSettings()
    public var font = FontSettings()
    
    public init(calendar: Calendar,
                minimumDate: Date,
                maximumDate: Date,
                startDate: Date? = nil,
                endDate: Date? = nil,
                disabledDates: [Date] = [],
                disabledAfterDate: Date? = nil) {
        
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.startDate = startDate
        self.endDate = endDate
        self.disabledDates = disabledDates
        self.disabledAfterDate = disabledAfterDate
    }
    
    public func disabledDatesContains(date: Date) -> Bool {
        if let disabledAfterDate {
            return date > disabledAfterDate
        }else if let _ = disabledDates.first(where: { calendar.isDate($0, inSameDayAs: date) }) {
            return true
        }
        return false
    }

}
