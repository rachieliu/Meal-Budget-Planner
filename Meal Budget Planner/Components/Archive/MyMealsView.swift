//
//  MyMealsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

struct MyMealsView: View {
    
    @State private var selectedDate = Date()
    

    let currentDate = Date()
    let calendar = Calendar.current
   
    
   @State private var tabSelection = 2


    
    var body: some View {
        
        
        NavigationView(){
            
            VStack(spacing: 0){
                HeaderView()
                
                
                
                
                Text("My Meal Plan")
                    .fontWeight(.bold)
                    //.padding(.top, 10)
                    .padding(.bottom)
                
                GeometryReader { geometry in

                    ScrollView(.horizontal, showsIndicators: false) {
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
    
                    }
                    
                }
                Divider()
                    .padding(.bottom, 0)
                
                
               
              
                VStack(spacing: 0) {
                    MealCategoryView(category: "B R E A K F A S T")
                    MealButton(title: "Meal Name")
                    MealCategoryView(category: "L U N C H")
                    MealButton(title: "Meal Name")
                    MealCategoryView(category: "D I N N E R ")
                    MealButton(title: "Meal Name")
                }
                .padding()
                Spacer()
                CustomTabView(tabSelection: $tabSelection)
                
                
                 // Pushes content to the top
                
                
                
                    
                
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            
        }
    }
    private func startOfWeek() -> Date {
        let today = calendar.startOfDay(for: currentDate)
        let dayOfWeek = calendar.component(.weekday, from: today)
        let offset = (dayOfWeek - 2) % 7 // Sunday is the last day of the week, so we use modulo 7
        return calendar.date(byAdding: .day, value: -offset, to: today)!
    }
}
            



struct MealButton: View {
    let title: String
    
    var body: some View {
        NavigationLink(destination: FirstBudgetBreakfast()) {
            HStack {
                Text(title)
                    //.fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    //.background(Color("PrimaryColor"))
                   // .cornerRadius(20)
                
                Spacer()
                
                Text("...")
                    //.fontWeight(.bold)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .padding(.trailing, 15)
                    .padding(.bottom)
            }
        }
        .background(Color("PrimaryColor"))
        .cornerRadius(20)
        
    }
}


struct MyMealsView_Previews: PreviewProvider {
    static var previews: some View {
        MyMealsView()
            
    }
}

struct MealCategoryView: View {
    let category: String
    
    var body: some View {
        Text(category)
            //.fontWeight(.bold)
            .font(.system(size: 20))

            .padding(.leading,-140)
            .padding(.top)
    }
}
