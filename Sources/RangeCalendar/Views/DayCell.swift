//
//  DayCell.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import SwiftUI


public struct DayCell: View {
    
    private var rcDate: RCDate
    
    private var cellWidth: CGFloat
    
    public init(rcDate: RCDate, cellWidth: CGFloat) {
        self.rcDate = rcDate
        self.cellWidth = cellWidth
    }
    
    private var corners: UIRectCorner{
        if rcDate.isStartDate {
            return [.topLeft, .bottomLeft]
        }else if rcDate.isEndDate{
            return [.topRight, .bottomRight]
        }else {
            return [.allCorners]
        }
    }
    
    private var radius: CGFloat{
        rcDate.isEndDate || rcDate.isStartDate ? cellWidth / 2 : 0
    }
    
    public var body: some View {
        Text(rcDate.getText())
            .font(rcDate.font)
            .foregroundColor(rcDate.getTextColor())
            .frame(height: cellWidth)
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 20))
            .background(rcDate.getBackgroundColor())
            .cornerRadius(radius, corners: corners)
    }
}


#if DEBUG
struct RKCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            DayCell(rcDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isBetweenStartAndEnd: false, isSelected: false), cellWidth: CGFloat(32))
                .previewDisplayName("Control")
            DayCell(rcDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: true, isToday: false, isBetweenStartAndEnd: false, isSelected: false), cellWidth: CGFloat(32))
                .previewDisplayName("Disabled Date")
            DayCell(rcDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: true, isBetweenStartAndEnd: false, isSelected: false), cellWidth: CGFloat(32))
                .previewDisplayName("Today")
            DayCell(rcDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isBetweenStartAndEnd: false, isSelected: true), cellWidth: CGFloat(32))
                .previewDisplayName("Selected Date")
            DayCell(rcDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isBetweenStartAndEnd: true, isSelected: false), cellWidth: CGFloat(32))
                .previewDisplayName("Between Two Dates")
        }
        .frame(width: 34, height: 34)
        .previewLayout(.fixed(width: 34, height: 70))
        .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif



