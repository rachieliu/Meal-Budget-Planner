//
//  CalendarView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var selectedDate = Date()
   // @Binding var path: [TabBarView.HomeNavigation]

    let currentDate = Date()
    let calendar = Calendar.current
    var body: some View {
        
        GeometryReader { geometry in
            
            

            ScrollView(.horizontal, showsIndicators: false) {
                Divider()
                
                HStack(spacing: -10) {
                    
                    
                    Button(action: {
                        self.selectedDate = self.calendar.date(byAdding: .weekOfYear, value: -1, to: self.selectedDate)!
                    }
                )
                    {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 15))
                            //.padding()
                            .foregroundColor(.black)
                            .padding(.leading, 10)
                            .padding(.trailing, 5)
                    }
                    
                    Spacer(minLength: (geometry.size.width / 7 - 20) / 2)
                    
                    ForEach(0..<7) { index in
                        let date = calendar.date(byAdding: .day, value: index, to: startOfWeek()) ?? Date()
                        let isSelected = calendar.isDate(date, inSameDayAs: currentDate)
                        CalendarDayView(date: date, isSelected: isSelected)
                            .frame(width: geometry.size.width / 7)
                    }
                    Spacer(minLength: (geometry.size.width / 7 - 20) / 2)
                    
                    Button(action: {
                        self.selectedDate = self.calendar.date(byAdding: .weekOfYear, value: 1, to: self.selectedDate)!
                    }) {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .padding(.trailing, 10)
                            .padding(.leading, 5)
                    }
                    
                }
                Divider()

            }
            
           // Divider()
            
            
        }
        
            
        
    }
    private func startOfWeek() -> Date {
        let today = calendar.startOfDay(for: currentDate)
        let dayOfWeek = calendar.component(.weekday, from: today)
        let offset = (dayOfWeek - 2) % 7 // Sunday is the last day of the week, so we use modulo 7
        return calendar.date(byAdding: .day, value: -offset, to: today)!
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
