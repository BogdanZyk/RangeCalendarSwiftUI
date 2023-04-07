//
//  RCDate.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import Foundation
import SwiftUI

public struct RCDate {
    
    public var date: Date
    public let manager: RCManager
    
    public var isDisabled: Bool = false
    public var isToday: Bool = false
    public var isSelected: Bool = false
    public var isBetweenStartAndEnd: Bool = false
    public var endDate: Date?
    public var startDate: Date?
    
    public init(date: Date,
                manager: RCManager,
                isDisabled: Bool,
                isToday: Bool,
                isBetweenStartAndEnd: Bool,
                isSelected: Bool,
                endDate: Date? = nil,
                startDate: Date? = nil) {
        
        self.date = date
        self.endDate = endDate
        self.startDate = startDate
        self.manager = manager
        self.isDisabled = isDisabled
        self.isToday = isToday
        self.isSelected = isSelected
        self.isBetweenStartAndEnd = isBetweenStartAndEnd
    }
    
    public var isEndDate: Bool{
        date == endDate
    }
    
    public var isStartDate: Bool{
        date == startDate
    }
    
    public func getText() -> String {
        let day = Helpers.formatDate(date: date, calendar: manager.calendar)
        return day
    }
    
    public func getTextColor() -> Color {
        var textColor = manager.colors.textColor
        if isDisabled {
            textColor = manager.colors.disabledColor
        } else if isSelected {
            textColor = manager.colors.selectedColor
        } else if isToday {
            textColor = manager.colors.todayColor
        } else if isBetweenStartAndEnd {
            textColor = manager.colors.betweenStartAndEndColor
        }
        return textColor
    }
    
    public func getBackgroundColor() -> Color {
        var backgroundColor = manager.colors.textBackColor
        if isBetweenStartAndEnd {
            backgroundColor = manager.colors.betweenStartAndEndBackColor
        }
        if isDisabled {
            backgroundColor = manager.colors.disabledBackColor
        }
        if isSelected {
            backgroundColor = manager.colors.selectedBackColor
        }
        return backgroundColor
    }
    
    public func getFontWeight() -> Font.Weight {
        var fontWeight = Font.Weight.medium
        if isDisabled {
            fontWeight = Font.Weight.thin
        } else if isSelected {
            fontWeight = Font.Weight.heavy
        } else if isToday {
            fontWeight = Font.Weight.heavy
        } else if isBetweenStartAndEnd {
            fontWeight = Font.Weight.heavy
        }
        return fontWeight
    }
    
}
