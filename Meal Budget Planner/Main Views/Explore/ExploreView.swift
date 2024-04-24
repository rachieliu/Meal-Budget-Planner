//
//  ExploreView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/13/24.
//

import SwiftUI
struct CombinedBox: Identifiable {
    let id: Int
    let title: String
    let image: String
}

struct Box: Identifiable {
    let id: Int
    let title: String
    let image: String
}

struct ExploreView: View {
    
    //State tracking
    @State private var selectedBoxId: Int? = nil
    
    let boxes: [Box] = [
        Box(id: 0, title: "All", image: "1b5"),
        Box(id: 1, title: "Breakfast", image: "2b5"),
        Box(id: 2, title: "Lunch", image: "4l1"),
        Box(id: 3, title: "Dinner", image: "3d4")
    ]
    
    var body: some View {
        TabView {
            ForEach(0..<4) { index in
                NavigationView {
                    VStack(spacing: 0) {
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(boxes) { box in
                                    Button(action: {
                                        // Select the corresponding tab
                                        print("Selected box ID:", box.id)
                                        self.selectedBoxId = box.id
                                    }) {
                                        BoxView(box: box, isSelected: self.selectedBoxId == box.id)
                                        
                                    }
                                   
                                }
                            }
                            .padding()
                        }
                        .padding()
                        
                    
                        VStack{
                            
                            
                            // Display content based on the selected tab
                             if let selectedBoxId = self.selectedBoxId {
                                 if selectedBoxId == 0 {
                                     AllMealsView()
                                 } else if selectedBoxId == 1 {
                                     BreakfastItemsView()
                                 } else if selectedBoxId == 2 {
                                     LunchItemsView()
                                 }else if selectedBoxId == 3 {
                                     DinnerItemsView()
                                 }
                            
                           
                            }
                        }
                      
                    }
                    .navigationBarTitle(Text("Explore"))
                    //.ignoresSafeArea()
                }
                .tag(index)
            }
        }
        
       .onAppear {
            // Set selectedBoxId to the id of Breakfast box when ExploreView appears
            self.selectedBoxId = 0
        }
        .edgesIgnoringSafeArea(.bottom)
       // .tabViewStyle(PageTabViewStyle())
    }
    //.edgesIgnoringSafeArea(.bottom)
}



struct BoxView: View {
    let box: Box
    let isSelected: Bool
    var body: some View {
        VStack {
            Image(box.image)
                .resizable()
                .cornerRadius(12)
                .frame(width: isSelected ? 90 : 80, height: isSelected ? 90 : 80) // Increase size when selected
                .scaleEffect(isSelected ? 1.2 : 1.0)
            Text(box.title)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular) // Increase font weight when selected
                .padding(.top, 10)
                .foregroundColor(.black)
                .overlay(
                    Rectangle()
                        .frame(height: 4) // Adjust the height of the underline
                        .padding(.top, 35) // Adjust the position of the underline
                        .foregroundColor(isSelected ? .pink : .clear) // Set the color of the underline
                )
                .scaleEffect(isSelected ? 1.2 : 1.0) // Increase scale when selected
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}


