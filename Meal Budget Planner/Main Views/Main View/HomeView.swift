//
//  MyMealsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//

import SwiftUI

struct HomeView: View {
    
    enum Tab {
      case grocery, home, explore, budget
     }
    
    @State private var selectedTab: Tab = .home
    
    @State private var selectedDate = Date()
   // @Binding var path: [TabBarView.HomeNavigation]

    let currentDate = Date()
    let calendar = Calendar.current
   
    
   //@State private var tabSelection = 2


    
    var body: some View {
        
        
        NavigationView(){
            
            VStack(spacing:0){
                HeaderView()
                    
                //Spacer()
                
                Text("My Meal Plan")
                    .fontWeight(.bold)
                    //.padding(.top, 10)
                    .padding(.bottom)
                Spacer()
                
                CalendarView()
                Spacer()
                .padding(.top, 50)
                    

                VStack(spacing: 0) {
                    MealButtonView(category: "B R E A K F A S T")
                    MealButtons(title: "Meal Name")
                    MealButtonView(category: "L U N C H")
                    MealButtons(title: "Meal Name")
                    MealButtonView(category: "D I N N E R ")
                    MealButtons(title: "Meal Name")
                }
                .padding()
                Spacer()
               // CustomTabView(tabSelection: $tabSelection)
                
                //TabBarView()
                //    .padding(.vertical)
                 // Pushes content to the top
                
                
               /* VStack{
                    TabView(selection: $selectedTab){
                        
                        GroceryListView()
                             .tabItem {

                                 Label("Grocery", systemImage: "cart")
                             }
                             .tag(Tab.grocery)
                        
                        HomeView()
                             .tabItem {

                                 Label("My Meals", systemImage: "house")
                             }
                             .tag(Tab.home)
                        
                        ExploreView()
                            .tabItem {

                                Label("Explore", systemImage: "network")
                            }
                            .tag(Tab.explore)
                        
                         MyBudgetView()
                             .tabItem {

                                 Label("Budget", systemImage: "gearshape")
                             }
                             .tag(Tab.budget)
                        
                        
                    }
                }*/
                //Spacer()
                    
                
            }
            .edgesIgnoringSafeArea(.top)
            
            
        }
        .navigationBarHidden(true)
        
    }
    /*private func startOfWeek() -> Date {
        let today = calendar.startOfDay(for: currentDate)
        let dayOfWeek = calendar.component(.weekday, from: today)
        let offset = (dayOfWeek - 2) % 7 // Sunday is the last day of the week, so we use modulo 7
        return calendar.date(byAdding: .day, value: -offset, to: today)!
    }*/
}
            



/*struct MealButtons: View {
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
*/

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .previewInterfaceOrientation(.portrait)
            HomeView()
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
            
    }
}
/*
struct MealTypeView: View {
    let category: String
    
    var body: some View {
        Text(category)
            //.fontWeight(.bold)
            .font(.system(size: 20))

            .padding(.leading,-140)
            .padding(.top)
    }
}
*/
