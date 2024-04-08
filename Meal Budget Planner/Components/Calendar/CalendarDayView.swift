//
//  CalendarDayView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/18/24.
//

import SwiftUI

struct CalendarDayView: View {
    let date: Date
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text("\(dayOfMonth(date: date))")
                .font(.system(size: 19))
                .foregroundColor(isSelected ? .white : .black)
                .padding(5)
                .background(isSelected ? Color("PrimaryColor") : Color.clear)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
                )
            Text(weekdayInitials(date: date))
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    
    private func dayOfMonth(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
    
    private func weekdayInitials(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}

struct CalendarDayView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample date and isSelected status for preview
        let sampleDate = Date()
        let isSelected = true
        
        // Pass the sample date and isSelected status when initializing CalendarDayView
        CalendarDayView(date: sampleDate, isSelected: isSelected)
    }
}
