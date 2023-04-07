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

    @Published public var calendar = Calendar.current
    @Published public var minimumDate: Date = Date()
    @Published public var maximumDate: Date = Date()
    @Published public var selectedDate: Date! = nil
    @Published public var startDate: Date! = nil
    @Published public var endDate: Date! = nil
    
    
    public var colors = ColorSettings()
    
    public init(calendar: Calendar,
                minimumDate: Date,
                maximumDate: Date,
                startDate: Date? = nil,
                endDate: Date? = nil) {
        
        self.calendar = calendar
        self.minimumDate = minimumDate
        self.maximumDate = maximumDate
        self.startDate = startDate
        self.endDate = endDate
        
    }    
}
