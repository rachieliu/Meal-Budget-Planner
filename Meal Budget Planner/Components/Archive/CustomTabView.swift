//
//  CustomTabView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/13/24.
//

import SwiftUI
/*
struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    @State private var isActive = false // Add isActive state
    
    let tabBarItems: [(image: String, title: String, destination: AnyView)] = [
        ("GroceryIcon", "Grocery", AnyView(GroceryListView())),
        ("ExploreIcon", "Explore", AnyView(ExploreView())),
        ("HomeIcon", "My Meals", AnyView(MyMealsView())),
        ("BudgetIcon", "My Budget", AnyView(MyBudgetView()))
    ]
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing: 0){
                Spacer()
                ForEach(0..<tabBarItems.count) { index in
                    GeometryReader{ geometry in
                        
                        NavigationLink(destination: self.tabBarItems[index].destination, isActive: Binding<Bool>(
                            get: {
                                return self.isActive && self.tabSelection == index
                            },
                            set: { newValue in
                                self.isActive = newValue
                                
                            })){
                            Button {
                                withAnimation {
                                    tabSelection = index
                                }
                                
                            }label:{
                                VStack(spacing : 3){
                                    Spacer()
                                    
                                    Image(tabBarItems[index].image)
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(index == tabSelection ? Color("PrimaryColor") : Color.black)
                                        .frame(width: 50, height: 35)
                                        .offset(y: index == tabSelection ? -5 : 0) // Offset for selected tab icon
                                    
                                    
                                    
                                    Text(tabBarItems[index].title)
                                        .font(.caption)
                                        .foregroundColor(Color.black)
                                        //.fontWeight(.bold)
                                    
                                    if tabSelection == index{
                                        Capsule()
                                            .frame(height: 8)
                                            .foregroundColor(Color("PrimaryColor"))
                                            .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                          //  .offset(y: )
                                    }else{
                                        Capsule()
                                            .frame(height: 8)
                                            .foregroundColor(.clear)
                                         //    .offset(y:3)
                                    }
                                    
                                    
                                
                                }
                                
                            }
                            .frame(width: geometry.size.width)
                            
                        }
                        
                    }
                   // .padding(.horizontal)
                
                }
                
               
            }
        }
        //.padding(.vertical)

        
    }
}*/
/*
struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String, destination: AnyView)] = [
        ("GroceryIcon", "Grocery", AnyView(GroceryListView())),
        ("ExploreIcon", "Explore", AnyView(ExploreView())),
        ("HomeIcon", "My Meals", AnyView(MyMealsView())),
        ("BudgetIcon", "My Budget", AnyView(MyBudgetView()))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(0..<tabBarItems.count) { index in
                    GeometryReader { geometry in
                        Button(action: {
                            tabSelection = index
                        }) {
                            VStack(spacing: 3) {
                                Spacer()
                                
                                Image(tabBarItems[index].image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(index == tabSelection ? Color("PrimaryColor") : Color.black)
                                    .frame(width: 50, height: 35)
                                    .offset(y: index == tabSelection ? -6 : 0) // Offset for selected tab icon
                                
                                Text(tabBarItems[index].title)
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                                
                                if tabSelection == index {
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(Color("PrimaryColor"))
                                        .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                        .offset(y: -3)
                                } else {
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(.clear)
                                }
                            }
                        }
                        .frame(width: geometry.size.width)
                    }
                }
            }
            
            
            Spacer() // Push the tab bar to the bottom
        }
    }
}
*/
struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    @State private var isActive = false // Add isActive state
    
    let tabBarItems: [(image: String, title: String, destination: AnyView)] = [
        ("GroceryIcon", "Grocery", AnyView(GroceryListView())),
        ("ExploreIcon", "Explore", AnyView(ExploreView())),
        ("HomeIcon", "My Meals", AnyView(MyMealsView())),
        ("BudgetIcon", "My Budget", AnyView(MyBudgetView()))
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(0..<4) { index in
                    GeometryReader { geometry in
                        NavigationLink(destination: tabBarItems[index].destination, isActive: Binding<Bool>(
                            get: {
                                return self.isActive && self.tabSelection == index
                            },
                            set: { newValue in
                                self.isActive = newValue
                            })
                        ){
                            VStack(spacing: 3) {
                                Spacer()
                                
                                Image(tabBarItems[index].image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(index == tabSelection ? Color("PrimaryColor") : Color.black)
                                    .frame(width: 50, height: 35)
                                    .offset(y: index == tabSelection ? -6 : 0) // Offset for selected tab icon
                                
                                Text(tabBarItems[index].title)
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                                
                                if tabSelection == index {
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(Color("PrimaryColor"))
                                        .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                        .offset(y: -3)
                                } else {
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(.clear)
                                }
                            }
                        }
                        .frame(width: geometry.size.width)
                    }
                }
            }
            
            
            Spacer() // Push the tab bar to the bottom
        }
    }
}




struct CustomTabView_Previews: PreviewProvider {
    @State static var tabSelection = 0  // Initialize tabSelection
    
    static var previews: some View {
        CustomTabView(tabSelection: $tabSelection)
            .previewLayout(.sizeThatFits)
            .padding(.vertical)
    }
}


