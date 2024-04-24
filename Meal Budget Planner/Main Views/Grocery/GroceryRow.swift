//
//  GroceryRow.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/9/24.
//


import SwiftUI

struct GroceryRow: View {
    
    let food: Food
    
    var body: some View {
        HStack {
            
            Text(food.name)
            
            .padding(.leading, 20)
            
        }
    }
}

struct GroceryRow_Previews: PreviewProvider {
    static var previews: some View {
        GroceryRow(food: Food(name: "Pizza", color: .red))
    }
}


