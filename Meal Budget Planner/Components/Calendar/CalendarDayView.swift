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
    @Binding var selectedDate: Date
    let onDateSelected: () -> Void // Closure to be called when adate is selected
    
    var body: some View {
        Button(action: {
            self.onDateSelected()
            print("Tapped Date: \(self.date)")
        }) {
            VStack {
                Text("\(dayOfMonth(date: date))")
                    .font(.system(size: 13))
                    .foregroundColor(isSelected ? Color("DarkGrey") : Color("DarkGrey"))
                    .padding(5)
                    .background(isSelected ? Color.white : Color.clear)
                    .clipShape(Circle())
                    .frame(width: isSelected ? 31 : 26, height: isSelected ? 31 : 26)
                
                    
                
                Text(weekdayInitials(date: date))
                    .font(.footnote)
                    .foregroundColor(isSelected ? Color("DarkGrey") : Color("DarkGrey"))
                
                
            }
            .padding(.horizontal, 8)
            .background(isSelected ? Color("BabyPink") : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color("DarkGrey"), lineWidth: isSelected ? 2 : 0) 
            )
            .onTapGesture {
                self.onDateSelected()
                print("Tapped Date: \(self.date)")
            }
            
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

