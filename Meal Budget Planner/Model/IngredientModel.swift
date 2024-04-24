//
//  IngredientModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/8/24.


import Foundation

struct Ingredient:Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var items: [IngredientItem]
}

struct IngredientItem:Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var done: Bool
}
