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
    @StateObject var viewModel = FavoritesViewModel()
    
    
    @State private var selectedTab: Tab = .home
    

    
    
    var body: some View {
        
        HStack {
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
                    .environmentObject(viewModel)
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
            .onAppear {
                self.selectedTab = .home // home default selected tab
        }
        }
        
       

        
        
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

