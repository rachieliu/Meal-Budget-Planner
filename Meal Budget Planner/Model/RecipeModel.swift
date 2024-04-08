//
//  RecipeModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/6/24.
//

import SwiftUI

struct Recipe: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var comments: String
    var calories: Int
    var image: String
  
    var instructions: [String]
    var ingredients: [String]
    var isBreakfast: Bool
    var isLunch: Bool
    var isDinner: Bool
    
    //var fat: Int
    //var satfat: Int
    //var carbs: Int
   // var fiber: Int
    //var sugar: Int
    //var protein: Int
}
