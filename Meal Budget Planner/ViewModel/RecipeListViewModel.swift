//
//  RecipeListViewModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/6/24.
//

import Foundation

final class RecipeListViewModel: ObservableObject {
    
    @Published var dataIsLoading: Bool = false
    @Published var dataBfastLoading: Bool = false
    @Published var dataLunchLoading: Bool = false
    @Published var dataDinnerLoading: Bool = false
    @Published var recipeData: [Recipe] = []
    @Published var bfastRecipeData: [Recipe] = []
    @Published var lunchRecipeData: [Recipe] = []
    @Published var dinnerRecipeData: [Recipe] = []
    
    init() {
        readAllData()
    }
    
    func readAllData() {
        
        self.dataIsLoading = true
        self.dataBfastLoading = true
        self.dataLunchLoading = true
        self.dataDinnerLoading = true
        
        self.recipeData = []
        self.bfastRecipeData = []
        self.lunchRecipeData = []
        self.dinnerRecipeData = []
        
        self.recipeData = sampleRecipes
        
        SearchDataManager.shared.setOriginalList(list: self.recipeData)
        
        for recipe in self.recipeData {
            // Add editor's list if flag true
            if recipe.isBreakfast {
                self.bfastRecipeData.append(recipe)
            }
            // Add trendings's list if flag true
            if recipe.isLunch {
                self.lunchRecipeData.append(recipe)
            }
            if recipe.isLunch {
                self.dinnerRecipeData.append(recipe)
            }
        }
        
        self.dataIsLoading = false
        self.dataBfastLoading = false
        self.dataLunchLoading = false
        self.dataDinnerLoading = false
    }
    
}

