//
//  ColorSettings.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import Foundation
import Combine
import SwiftUI

@available(macOS 10.15, *)
public class ColorSettings : ObservableObject {

    // foreground colors
    @Published public var textColor: Color = Color.primary
    @Published public var todayColor: Color = Color.red
    @Published public var selectedColor: Color = Color.white
    @Published public var disabledColor: Color = Color.gray
    @Published public var betweenStartAndEndColor: Color = Color.white
    // background colors
    @Published public var textBackColor: Color = Color.clear
    @Published public var todayBackColor: Color = Color.gray
    @Published public var selectedBackColor: Color = Color.blue
    @Published public var disabledBackColor: Color = Color.clear
    @Published public var betweenStartAndEndBackColor: Color = Color(.systemGray3)
    @Published public var calendarBackColor: Color = Color(.systemGray6)
    // headers foreground colors
    @Published public var weekdayHeaderColor: Color = .secondary
    @Published public var monthHeaderColor: Color = Color.primary
    // headers background colors
    @Published public var weekdayHeaderBackColor: Color = Color.clear
    @Published public var monthBackColor: Color = Color.clear

}
