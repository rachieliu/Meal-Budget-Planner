//
//  Food.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/9/24.
//

import SwiftUI

struct Food: Identifiable, Hashable {
    var name: String
    var color: Color
    let id = UUID()
    
    static func Produce() -> [Food] {
        return [Food(name: "Apple", color: .red),
                Food(name: "Orange", color: .orange),
                Food(name: "Banana", color: .yellow),
                Food(name: "Broccoli", color: .yellow),
                Food(name: "Lettuce", color: .yellow)]
    }
    
    static func Dairy() -> [Food] {
        [Food(name: "Greek Yogurt", color: .blue),
         Food(name: "Eggs", color: .green),
         Food(name: "Cheese", color: .green)]
    }
    
    static func Meat() -> [Food] {
        return [Food(name: "Chicken",  color: .red),
                Food(name: "Salmon", color: .orange),
                Food(name: "Steak",  color: .yellow)]
    }
    
    static func Grains() -> [Food] {
        [Food(name: "Whole Grain Bread", color: .blue),
         Food(name: "Pasta", color: .green)]
    
    }
    static func Other() -> [Food] {
        [Food(name: "Pizza", color: .blue),
         Food(name: "Burger", color: .green)]
    }
}

