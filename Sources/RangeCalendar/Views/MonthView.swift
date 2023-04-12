//
// MonthView.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import SwiftUI

public struct MonthView: View {

    @State private var isStartDate: Bool = true
    
    @ObservedObject private var manager: RCManager
    
    
    public init(manager: RCManager, monthOffset: Int){
        self.monthOffset = monthOffset
        self._manager = ObservedObject(wrappedValue: manager)
    }
    
    private let monthOffset: Int
    
    private let calendarUnitYMD = Set<Calendar.Component>([.year, .month, .day])
    private let daysPerWeek = 7
    private var monthsArray: [[Date]] {
        monthArray()
    }
    private let cellWidth = CGFloat(32)
    
    @State private var showTime = false
    
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(getMonthHeader())
                .font(.title3.bold())
                .foregroundColor(self.manager.colors.monthHeaderColor)
                .padding(.leading)
            VStack(alignment: .leading, spacing: 5) {
                ForEach(monthsArray, id:  \.self) { row in
                    HStack(spacing: 0){
                        ForEach(row, id:  \.self) { column in
                            cellView(column)
                        }
                    }
                }
            }
        }.background(manager.colors.monthBackColor)
    }
}

#if DEBUG
struct MonthView_Previews : PreviewProvider {
    static var previews: some View {
        MonthView(manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)), monthOffset: 0)
    }
}
#endif

public extension MonthView{
    
    private func cellView(_ column: Date) -> some View{
        HStack(spacing: 0) {
            if self.isThisMonth(date: column) {
                DayCell(rcDate: RCDate(
                    date: column,
                    manager: manager,
                    isDisabled: !isEnabled(date: column),
                    isToday: isToday(date: column),
                    isBetweenStartAndEnd: isBetweenStartAndEnd(date: column), isSelected: isSpecialDate(date: column),
                    endDate: manager.endDate,
                    startDate: manager.startDate),
                    cellWidth: self.cellWidth)
                    .onTapGesture { self.dateTapped(date: column) }
            } else {
                Text("")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
}


public extension MonthView{
    func isThisMonth(date: Date) -> Bool {
        return self.manager.calendar.isDate(date, equalTo: firstOfMonthForOffset(), toGranularity: .month)
    }
   
   func dateTapped(date: Date) {
       if self.isEnabled(date: date) {
           
           
           if isStartDate{
               self.manager.startDate = date
               self.manager.endDate = nil
               isStartDate = false
           }else{
               self.manager.endDate = date
               if self.isStartDateAfterEndDate() {
                   self.manager.endDate = nil
                   self.manager.startDate = nil
               }
               isStartDate = true
           }
       }
   }
    
   func monthArray() -> [[Date]] {
       var rowArray = [[Date]]()
       for row in 0 ..< (numberOfDays(offset: monthOffset) / 7) {
           var columnArray = [Date]()
           for column in 0 ... 6 {
               let abc = self.getDateAtIndex(index: (row * 7) + column)
               columnArray.append(abc)
           }
           rowArray.append(columnArray)
       }
       return rowArray
   }
   
   func getMonthHeader() -> String {
       let headerDateFormatter = DateFormatter()
       headerDateFormatter.calendar = manager.calendar
       headerDateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy LLLL", options: 0, locale: manager.calendar.locale)
       
       return headerDateFormatter.string(from: firstOfMonthForOffset())
   }
   
   func getDateAtIndex(index: Int) -> Date {
       let firstOfMonth = firstOfMonthForOffset()
       let weekday = manager.calendar.component(.weekday, from: firstOfMonth)
       var startOffset = weekday - manager.calendar.firstWeekday
       startOffset += startOffset >= 0 ? 0 : daysPerWeek
       var dateComponents = DateComponents()
       dateComponents.day = index - startOffset
       
       return manager.calendar.date(byAdding: dateComponents, to: firstOfMonth)!
   }
   
   func numberOfDays(offset : Int) -> Int {
       let firstOfMonth = firstOfMonthForOffset()
       let rangeOfWeeks = manager.calendar.range(of: .weekOfMonth, in: .month, for: firstOfMonth)
       
       return (rangeOfWeeks?.count)! * daysPerWeek
   }
   
   func firstOfMonthForOffset() -> Date {
       var offset = DateComponents()
       offset.month = monthOffset
       
       return manager.calendar.date(byAdding: offset, to: firstDateMonth())!
   }
   
   func formatDate(date: Date) -> Date {
       let components = manager.calendar.dateComponents(calendarUnitYMD, from: date)
       
       return manager.calendar.date(from: components)!
   }
   
   func formatAndCompareDate(date: Date, referenceDate: Date) -> Bool {
       let refDate = formatDate(date: referenceDate)
       let clampedDate = formatDate(date: date)
       return refDate == clampedDate
   }
   
   func firstDateMonth() -> Date {
       var components = manager.calendar.dateComponents(calendarUnitYMD, from: manager.minimumDate)
       components.day = 1
       
       return manager.calendar.date(from: components)!
   }
   
   // MARK: - Date Property Checkers
   
   func isToday(date: Date) -> Bool {
       return formatAndCompareDate(date: date, referenceDate: Date())
   }
    
   func isSpecialDate(date: Date) -> Bool {
       return isSelectedDate(date: date) ||
           isStartDate(date: date) ||
           isEndDate(date: date)
   }
   

   func isSelectedDate(date: Date) -> Bool {
       if manager.selectedDate == nil {
           return false
       }
       return formatAndCompareDate(date: date, referenceDate: manager.selectedDate)
   }
   
   func isStartDate(date: Date) -> Bool {
       if manager.startDate == nil {
           return false
       }
       return formatAndCompareDate(date: date, referenceDate: manager.startDate)
   }
   
   func isEndDate(date: Date) -> Bool {
       if manager.endDate == nil {
           return false
       }
       return formatAndCompareDate(date: date, referenceDate: manager.endDate)
   }
   
   func isBetweenStartAndEnd(date: Date) -> Bool {
       if manager.startDate == nil {
           return false
       } else if manager.endDate == nil {
           return false
       } else if manager.calendar.compare(date, to: manager.startDate, toGranularity: .day) == .orderedAscending {
           return false
       } else if manager.calendar.compare(date, to: manager.endDate, toGranularity: .day) == .orderedDescending {
           return false
       }
       return true
   }
   
   
   func isEnabled(date: Date) -> Bool {
       let clampedDate = formatDate(date: date)
       if manager.calendar.compare(clampedDate, to: manager.minimumDate, toGranularity: .day) == .orderedAscending || manager.calendar.compare(clampedDate, to: manager.maximumDate, toGranularity: .day) == .orderedDescending {
           return false
       }
       return !isOneOfDisabledDates(date: date)
   }
    
    func isOneOfDisabledDates(date: Date) -> Bool {
        self.manager.disabledDatesContains(date: date)
    }
   
   func isStartDateAfterEndDate() -> Bool {
       if manager.startDate == nil {
           return false
       } else if manager.endDate == nil {
           return false
       } else if manager.calendar.compare(manager.endDate, to: manager.startDate, toGranularity: .day) == .orderedDescending {
           return false
       }
       return true
   }
}
