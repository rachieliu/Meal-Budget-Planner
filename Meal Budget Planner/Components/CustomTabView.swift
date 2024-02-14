//
//  CustomTabView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/13/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
        
        ("GroceryIcon", "Grocery"),
        ("ExploreIcon", "Explore"),
        ("HomeIcon", "My Meals"),
        ("BudgetIcon", "My Budget")

    ]
    
    var body: some View {
        ZStack(alignment: .center){
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color(.secondarySystemBackground))
                .shadow(radius:2)
            
            HStack{
                ForEach(0..<4){ index in
                    GeometryReader{ reader in
                        
                        Button{
                            tabSelection = index + 1
                            
                        }label:{
                            VStack(spacing : 3){
                                Spacer()
                                
                                Image(tabBarItems[index].image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(index == tabSelection ? Color.gray : Color.black)
                                    .frame(width: 50, height: 50)
                                
                                
                                
                                Text(tabBarItems[index].title)
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                                    .fontWeight(.bold)
                                
                                if index + 1 == tabSelection{
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(Color("PrimaryColor"))
                                        .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                        .offset(y: 2)
                                }else{
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(.clear)
                                        .offset(y:3)
                                }
                                
                                
                            
                            }
                        }

                    }
                
                }
            }
           
            .frame(width: UIScreen.main.bounds.width, height: 90)
            //.clipShape(Capsule())
        }
            
            
            
            .padding(.horizontal)
            //.padding(.bottom, geometry.safeAreaInsets.bottom)
        
        
       
        
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(tabSelection: .constant(1))
            .previewLayout(.sizeThatFits)
            .padding(.vertical)
    }
}

/*
struct CustomTabView<Destination: View>: View {
    @Binding var tabSelection: Int
    
    @Namespace private var animationNamespace
    private let tabBarItems: [(image: String, title: String, destination: Destination)]
    

    init(tabSelection: Binding<Int>, tabBarItems: [(image: String, title: String, destination: Destination)]) {
        self._tabSelection = tabSelection
        self.tabBarItems = tabBarItems
    }

    var body: some View {
        ZStack {
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color.white)
                .shadow(radius: 2)

            HStack {
                ForEach(tabBarItems.indices) { index in
                    NavigationLink(
                        destination: tabBarItems[index].destination,
                        tag: index + 1,
                        selection: $tabSelection
                    ) {
                        VStack(spacing: 6) {
                            Spacer()

                            Image(tabBarItems[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)

                            Text(tabBarItems[index].title)
                                .font(.caption)
                                .foregroundColor(Color.black)
                                .fontWeight(.bold)

                            if index + 1 == tabSelection {
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(Color("PrimaryColor"))
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                    .offset(y: 3)
                            } else {
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(.clear)
                                    .offset(y: 3)
                            }
                        }
                    }
                    .frame(width: 90, height: 80)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 80)
        }
        .padding(.horizontal)
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomTabView(tabSelection: .constant(1), tabBarItems: [
            ("GroceryIcon", "Grocery", GroceryListView()),
            ("ExploreIcon", "Explore", ExploreView()),
            ("HomeIcon", "My Meals", MyMealsView()),
            ("BudgetIcon", "My Budget", MyBudgetView())
        ])
        .previewLayout(.sizeThatFits)
        .padding(.vertical)
    }
}*/

/*import SwiftUI

struct CustomTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
        
        ("GroceryIcon", "Grocery"),
        ("ExploreIcon", "Explore"),
        ("HomeIcon", "My Meals"),
        ("BudgetIcon", "My Budget")

    ]
 
             ("GroceryIcon", "Grocery", GroceryListView()),
             ("ExploreIcon", "Explore", ExploreView()),
             ("HomeIcon", "My Meals", MyMealsView()), // Use MyMealsView for the "My Meals" tab
             ("BudgetIcon", "My Budget", MyBudgetView())
             ])
    
    var body: some View {
        ZStack{
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color.white)
              //  .shadow(radius:2)
            
            HStack{
                ForEach(0..<4){ index in
                    GeometryReader{ reader in
                        
                        Button{
                            withAnimation(Animation.interactiveSpring(dampingFraction: 2)){
                                tabSelection = index + 1
                            }
                           
                            
                        }label:{
                            VStack(spacing : 3){
                                Spacer()
                                
                                Image(tabBarItems[index].image)
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(index + 1 == tabSelection ? Color("PrimaryColor") : Color.black)
                                    .background(Color.white.opacity(tabSelection == index + 1 ? 1 : 0).clipShape(Circle()))
                                    /*.overlay{
                                        RoundedRectangle(cornerRadius:60)
                                            .stroke(.black, lineWidth: 3)
                                    }*/
                                    .offset(x: 0, y: tabSelection == index + 1 ? -20: 0)
                                    //.foregroundStyle(.blue)
                                    //.frame(width: 45, height: 45)
                                
                                
                                
                                Text(tabBarItems[index].title)
                                    .font(.caption)
                                    .foregroundColor(Color.black)
                                    .fontWeight(.bold)
                                
                                if index + 1 == tabSelection{
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(Color("PrimaryColor"))
                                        .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                        .offset(y: 3)
                                }else{
                                    Capsule()
                                        .frame(height: 8)
                                        .foregroundColor(.clear)
                                        .offset(y:3)
                                }
                                
                                
                            
                            }
                        }
                     

                    }
                    .frame(width:90, height:80)
                
                }
            }
            
           
           // .frame(width: UIScreen.main.bounds.width, height: 80)
            
            
            //.clipShape(Capsule())
        }
            
            
            
            //.padding(.horizontal)
            //.padding(.bottom, geometry.safeAreaInsets.bottom)
        
        
       
        
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(tabSelection: .constant(1))
            .previewLayout(.sizeThatFits)
            .padding(.vertical)
    }
}
*/
