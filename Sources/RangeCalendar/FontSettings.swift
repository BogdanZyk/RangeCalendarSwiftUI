//
//  FontSettings.swift
//  
//
//  Created by Bogdan Zykov on 30.08.2023.
//

import Foundation
import SwiftUI

@available(macOS 10.15, *)
public class FontSettings: ObservableObject {
    
    // MARK: Month header
    @Published public var monthHeaderFont: Font = .body.bold()
    
    // MARK: Weekday header
    @Published public var weekdayHeaderFont: Font = .caption
    
    // MARK: Day cell font
    @Published public var cellUnselectedFont: Font = .body
    @Published public var cellIsDisabledFont: Font = .body.weight(.light)
    @Published public var cellSelectedFont: Font = .body.bold()
    @Published public var cellIsTodayFont: Font = .body.bold()
    @Published public var cellIsBetweenStartAndEndFont: Font = .body.bold()
    
}
