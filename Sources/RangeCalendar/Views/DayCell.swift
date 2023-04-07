//
//  DayCell.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import SwiftUI


public struct DayCell: View {
    
    public var rkDate: RCDate
    
    public var cellWidth: CGFloat
    
    public var corners: UIRectCorner{
        if rkDate.isStartDate {
            return [.topLeft, .bottomLeft]
        }else if rkDate.isEndDate{
            return [.topRight, .bottomRight]
        }else {
            return [.allCorners]
        }
    }
    
    public var radius: CGFloat{
        rkDate.isEndDate || rkDate.isStartDate ? cellWidth / 2 : 0
    }
    
    public  var body: some View {
        Text(rkDate.getText())
            .fontWeight(rkDate.getFontWeight())
            .foregroundColor(rkDate.getTextColor())
            .frame(height: cellWidth)
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 20))
            .background(rkDate.getBackgroundColor())
            .cornerRadius(radius, corners: corners)
    }
}


#if DEBUG
struct RKCell_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            DayCell(rkDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(32))
                .previewDisplayName("Control")
            DayCell(rkDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: true, isToday: false, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(32))
                .previewDisplayName("Disabled Date")
            DayCell(rkDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: true, isSelected: false, isBetweenStartAndEnd: false), cellWidth: CGFloat(32))
                .previewDisplayName("Today")
            DayCell(rkDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isSelected: true, isBetweenStartAndEnd: false), cellWidth: CGFloat(32))
                .previewDisplayName("Selected Date")
            DayCell(rkDate: RCDate(date: Date(), manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), isDisabled: false, isToday: false, isSelected: false, isBetweenStartAndEnd: true), cellWidth: CGFloat(32))
                .previewDisplayName("Between Two Dates")
        }
        .frame(width: 34, height: 34)
        .previewLayout(.fixed(width: 34, height: 70))
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}
#endif



