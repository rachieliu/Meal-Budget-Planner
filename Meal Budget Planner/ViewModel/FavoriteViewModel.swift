//
//  FavoriteViewModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/6/24.
//

import SwiftUI

final class FavoriteViewModel: ObservableObject {
    
    @Published var favoriteRecipes: [Recipe] = []
    
    let defaults = UserDefaults.standard
    
    init() {
        let data = defaults.data(forKey: keyFavorites)
        if (data != nil) {
            favoriteRecipes = try! JSONDecoder().decode([Recipe].self, from: data!)
        }
    }
}

extension FavoriteViewModel {
    func addRecipeToFavorites(recipe: Recipe) {
        favoriteRecipes.append(recipe)
        let data = try! JSONEncoder().encode(favoriteRecipes)
        defaults.set(data, forKey: keyFavorites)
    }
    
    func removeRecipeFromFavorites(recipe: Recipe) {
        if let index = favoriteRecipes.firstIndex(of: recipe) {
            favoriteRecipes.remove(at: index)
        }
        let data = try! JSONEncoder().encode(favoriteRecipes)
        defaults.set(data, forKey: keyFavorites)
    }
}
