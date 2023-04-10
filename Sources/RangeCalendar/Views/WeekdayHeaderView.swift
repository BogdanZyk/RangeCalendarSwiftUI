//
//  WeekdayHeaderView.swift
//  
//
//  Created by Bogdan Zykov on 07.04.2023.
//

import Foundation
import SwiftUI

public struct WeekdayHeaderView : View {
    
    public var manager: RCManager
    
    private var weekdays: [String]{
        Helpers.getWeekdayHeaders(calendar: manager.calendar)
    }
     
    public var body: some View {
        HStack(alignment: .center) {
            ForEach(weekdays, id: \.self) { weekday in
                Text(weekday)
                    .font(.system(size: 18))
                    .foregroundColor(manager.colors.weekdayHeaderColor)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(manager.colors.weekdayHeaderColor)
            }
        }.background(manager.colors.weekdayHeaderBackColor)
    }
}

#if DEBUG
struct WeekdayHeaderView_Previews : PreviewProvider {
    static var previews: some View {
        WeekdayHeaderView(manager: RCManager(calendar: Calendar.current, minimumDate: Date(), maximumDate: Date().addingTimeInterval(60*60*24*365)))
    }
}
#endif
