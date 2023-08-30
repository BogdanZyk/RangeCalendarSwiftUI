//
//  RCDate.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import Foundation
import SwiftUI

public struct RCDate {
    
    private var date: Date
    private let manager: RCManager
    
    private var isDisabled: Bool = false
    private var isToday: Bool = false
    private var isSelected: Bool = false
    private var isBetweenStartAndEnd: Bool = false
    private var endDate: Date?
    private var startDate: Date?
    
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
    
    var isStartDate: Bool{
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
    
    public var font: Font {
        var fontWeight = manager.font.cellUnselectedFont
        if isDisabled {
            fontWeight = manager.font.cellIsDisabledFont
        } else if isSelected {
            fontWeight = manager.font.cellSelectedFont
        } else if isToday {
            fontWeight = manager.font.cellIsTodayFont
        } else if isBetweenStartAndEnd {
            fontWeight = manager.font.cellIsBetweenStartAndEndFont
        }
        return fontWeight
    }
}
