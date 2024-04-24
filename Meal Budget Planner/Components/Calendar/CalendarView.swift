//
//  CalendarView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//

import SwiftUI


struct CalendarView: View {
    
    @Binding var selectedDate: Date
    @ObservedObject var viewModel: MyMealsViewModel // Pass the view model
    let calendar = Calendar.current
    

    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                Divider()
                    .padding(.bottom,-10)
                    .foregroundColor(Color("Black"))
                HStack(spacing: -10) {
                    Button(action: {
                        self.selectedDate = self.calendar.date(byAdding: .weekOfYear, value: -1, to: self.selectedDate)!
                        viewModel.fetchMealSelectionsAndUpdateView(for: self.selectedDate)
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            //.padding(.leading, 10)
                            .padding(.trailing, 5)
                    }
                    .padding(.leading,5)
                    Spacer(minLength: (geometry.size.width / 8 - 20) / 2)
                    HStack {
                        ForEach(0..<7) { index in
                            
                            let date = calendar.date(byAdding: .day, value: index, to: startOfWeek()) ?? Date()
                            let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                            // Pass a binding to the selected date to CalendarDayView
                            Spacer()
                            CalendarDayView(date: date, isSelected: isSelected, selectedDate: $selectedDate){
                                self.selectedDate = date
                                print("Selected Date: \(self.selectedDate)") // Print selected date
                                viewModel.fetchMealSelectionsAndUpdateView(for: date)
                            }
                            
                            .frame(width: geometry.size.width / 8)
                            .padding(.horizontal,-6.5)
                            Spacer()
                            
                            
                            
                        }
                        //.background(Color("white"))
                        //.cornerRadius(10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                   
                    Spacer(minLength: (geometry.size.width / 8 - 20) / 2)
                    Button(action: {
                        self.selectedDate = self.startOfNextWeek()

                        viewModel.fetchMealSelectionsAndUpdateView(for: self.selectedDate)
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                           // .padding(.trailing, 10)
                            .padding(.leading, 5)
                    }
                    .padding(.trailing,5)
                }
                .padding(.vertical,0.05)
               // .cornerRadius(20)
                
                Divider()
                    .padding(.top,-5)
                    .foregroundColor(Color("Black"))
            }
            //.background(Color("Barf"))
            
            
        }
       
      
        
    }

    
    
    private func startOfWeek() -> Date {
        let today = calendar.startOfDay(for: selectedDate)
        let dayOfWeek = calendar.component(.weekday, from: today)
        
        let offset = (dayOfWeek - 1) % 7 // Sunday is the last day of the week, use modulo 7
        return calendar.date(byAdding: .day, value: -offset, to: today)!
    }
    
    private func date(for index: Int) -> Date {
        calendar.date(byAdding: .day, value: index, to: startOfWeek()) ?? Date()
    }
    private func isSelected(for date: Date) -> Bool {
         let startOfNextWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek())!
         return calendar.isDate(date, inSameDayAs: startOfNextWeek)
     }
    
    private func startOfNextWeek() -> Date {
        let nextWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: selectedDate)!
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeek))!
    }
    
    
    /*
    private func fetchMealSelections(){
        print("Fetching meal selections for date: \(selectedDate)")
        viewModel.fetchMealSelections(for: selectedDate)
    }*/
  /*
    private func fetchMealSelections() {
        #if DEBUG
       viewModel.mockFetchMealSelections(for: selectedDate)
        #else
        viewModel.fetchMealSelections(for: selectedDate)
        #endif
    }*/
}
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let selectedDate = Date()
        let viewModel = MyMealsViewModel()
        
        return CalendarView(selectedDate: .constant(selectedDate), viewModel: viewModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
