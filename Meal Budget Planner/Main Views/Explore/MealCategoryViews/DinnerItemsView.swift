//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//


import SwiftUI

struct DinnerItemsView: View {
    
    let dinnerImageNames = ["1d1", "1d2", "1d3", "1d4", "1d5", "2d1", "2d2", "2d3", "2d4", "2d5"]
    let dinnerImageNames2 = ["3d1", "3d2", "3d3", "3d4", "3d5", "4d1", "4d2", "4d3", "4d4", "4d5"]
    
    @State private var mealItemStates: [MealItemViewState] = Array(repeating: MealItemViewState(), count: 20)
    
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack{
                  
                    HStack(alignment: .top) {
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<dinnerImageNames.count, id: \.self) { index in
                                let mealItem = MealItem(name: "Dinner \(index)", imageName: dinnerImageNames[index], isFavorite: self.mealItemStates[index].isFavorite) // Create a MealItem instance
                                MealItemView(mealItem: mealItem, isExpanded: self.$mealItemStates[index].isExpanded, isFavorite: self.$mealItemStates[index].isFavorite)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Second set of meal images
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<dinnerImageNames2.count, id: \.self) { index in
                                let realIndex = index + dinnerImageNames.count
                                let mealItem = MealItem(name: "Breakfast \(index)", imageName: dinnerImageNames2[index], isFavorite: self.mealItemStates[realIndex].isFavorite)
                                MealItemView(mealItem: mealItem, isExpanded: self.$mealItemStates[realIndex].isExpanded, isFavorite: self.$mealItemStates[realIndex].isFavorite)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    Spacer()
                   
                    
                }
            }
            .navigationBarHidden(true)
           
        }
        
        
    }
}


struct DinnerItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        DinnerItemsView()
    }
}

