//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//


import SwiftUI

struct LunchItemsView: View {
    let lunchImagesNames = ["1l1", "1l2", "1l3", "1l4", "1l5", "2l1", "2l2", "2l3", "2l4", "2l5"]
    let lunchImagesNames2 = ["3l1", "3l2", "3l3", "3l4", "3l5", "4l1", "4l2", "4l3", "4l4", "4l5"]
    
    @State private var mealItemStates: [MealItemViewState] = Array(repeating: MealItemViewState(), count: 20)
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack {
                    // Display meal images
                    HStack(alignment: .top) {
                        
                        // First set of meal images
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<lunchImagesNames.count, id: \.self) { index in
                                let mealItem = MealItem(name: "Lunch \(index)", imageName: lunchImagesNames[index], isFavorite: self.mealItemStates[index].isFavorite) // Create a MealItem instance
                                MealItemView(mealItem: mealItem, isExpanded: self.$mealItemStates[index].isExpanded, isFavorite: self.$mealItemStates[index].isFavorite)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Second set of meal images
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<lunchImagesNames2.count, id: \.self) { index in
                                let realIndex = index + lunchImagesNames2.count
                                let mealItem = MealItem(name: "Lunch \(index)", imageName: lunchImagesNames2[index], isFavorite: self.mealItemStates[realIndex].isFavorite)
                                MealItemView(mealItem: mealItem, isExpanded: self.$mealItemStates[realIndex].isExpanded, isFavorite: self.$mealItemStates[realIndex].isFavorite)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                    Spacer()
                }

             
                
            }
           
           
        }
        
        
    }
}


struct LunchItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        LunchItemsView()
    }
}

