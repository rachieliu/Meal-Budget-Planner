//
//  MealItem.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/16/24.
//

import Foundation

struct MealItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    var isFavorite: Bool = false
}


