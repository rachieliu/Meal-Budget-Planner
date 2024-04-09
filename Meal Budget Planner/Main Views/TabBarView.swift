//
//  TabBarView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//


import SwiftUI



struct TabBarView: View {
    
    
    enum Tab {
      case grocery,explore, home, favorites, settings
     }
    
    /*enum GroceryNavigation: Hashable {
            case child, secondChild
        }
    enum HomeNavigation: Hashable {
            case child, secondChild
        }
    enum ExploreNavigation: Hashable {
            case child, secondChild
        }
    enum BudgetNavigation: Hashable {
            case child, secondChild
        }*/
    
    
    
    
    @State private var selectedTab: Tab = .home
    
    // State property to track navigation stack for the home tab
   // @State private var groceryNavigationStack: [GroceryNavigation] = []
   // @State private var homeNavigationStack: [HomeNavigation] = []
   // @State private var exploreNavigationStack: [ExploreNavigation] = []
    //@State private var budgetNavigationStack: [BudgetNavigation] = []
    
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            
            GroceryListView()
                 .tabItem {

                     Label("Grocery", systemImage: "cart")
                 }
                 .tag(Tab.grocery)
            
            ExploreView()
                .tabItem {

                    Label("Explore", systemImage: "network")
                }
                .tag(Tab.explore)
            
            HomeView()
                 .tabItem {

                     Label("My Meals", systemImage: "house")
                 }
                 .tag(Tab.home)
            
            FavoritesView()
                .tabItem{
                    Label("Favorites", systemImage: "heart")
                }
                .tag(Tab.favorites)
            
            

            
            
             MyAccountView()
                 .tabItem {

                     Label("Settings", systemImage: "gearshape")
                 }
                 .tag(Tab.settings)
            
            
        }
        .navigationBarBackButtonHidden(true)
        .edgesIgnoringSafeArea(.top)
       

        
        
    }
}

extension TabBarView {
 
 private func tabSelection() -> Binding<Tab> {
    Binding { //this is the get block
     self.selectedTab
    } set: { tappedTab in
     if tappedTab == self.selectedTab {
      //User tapped on the currently active tab icon => Pop to root/Scroll to top
     }
     //Set the tab to the tabbed tab
     self.selectedTab = tappedTab
    }
 }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}

