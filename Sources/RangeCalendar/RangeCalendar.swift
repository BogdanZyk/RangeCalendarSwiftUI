//
// RangeCalendar.swift
//
//
//  Created by Bogdan Zykov on 07.04.2023.
//


import SwiftUI

public struct RangeCalendar: View {
    @ObservedObject var manager: RCManager
    
    public init(manager: RCManager){
        self._manager = ObservedObject(wrappedValue: manager)
    }
    
    private var numberOfMonths: Int{
        Helpers.numberOfMonths(manager.calendar, minDate: manager.minimumDate, maxDate: manager.maximumDate)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            weekDayHeader
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 32) {
                        ForEach(0..<numberOfMonths, id: \.self) { index in
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
                            proxy.scrollTo(Helpers.getMonthDayFromDate(date: date), anchor: .center)
                        }
                    }
                }
            }
        }
        .background(manager.colors.calendarBackColor.ignoresSafeArea())
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
