//
// RangeCalendar.swift
//
//
//  Created by Bogdan Zykov on 07.04.2023.
//


import SwiftUI

public struct RangeCalendar: View {
    @ObservedObject var manager: RCManager
    public var body: some View {
        VStack(spacing: 0) {
            weekDayHeader
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 32) {
                        ForEach(0..<numberOfMonths(), id: \.self) { index in
                            MonthView(manager: manager, monthOffset: index)
                                .id(index)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical)
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                        if let date = manager.startDate{
                            proxy.scrollTo(getMonthFromDate(date: date), anchor: .center)
                        }
                    }
                }
            }
        }
        .background(manager.colors.calendarBackColor.ignoresSafeArea())
    }
    
    func numberOfMonths() -> Int {
        return manager.calendar.dateComponents([.month], from: manager.minimumDate, to: RKMaximumDateMonthLastDay()).month! + 1
    }
    
    func RKMaximumDateMonthLastDay() -> Date {
        var components = manager.calendar.dateComponents([.year, .month, .day], from: manager.maximumDate)
        components.month! += 1
        components.day = 0
        
        return manager.calendar.date(from: components)!
    }
    
    func getMonthFromDate(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: date)
        return components.month! - 1
    }

}

#if DEBUG
struct RangeCalendar_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            RangeCalendar(manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)))
            RangeCalendar(manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)))
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif


public extension RangeCalendar{
    
    private var weekDayHeader: some View{
        VStack(spacing: 10) {
            WeekdayHeaderView(manager: manager)
                .padding(.horizontal)
            Divider()
        }
    }
    
}
