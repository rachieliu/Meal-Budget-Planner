//
//  SearchDataManager.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/6/24.
//

import Foundation

class SearchDataManager: ObservableObject {
    
    static let shared = SearchDataManager()
    
    @Published var recipeList = [Recipe]()
    
    var originalRecipeList = [Recipe]()
    
    func setOriginalList(list:[Recipe]) {
        self.originalRecipeList = list
        self.recipeList = list
    }
    
    func resetToOriginal() {
        if recipeList.count != originalRecipeList.count {
            recipeList = originalRecipeList
        }
    }
    
    func setEmpty() {
        if !recipeList.isEmpty {
            recipeList.removeAll()
        }
    }
    
    func search(text: String) {
        recipeList = originalRecipeList.filter{ $0.title.lowercased().contains(text.lowercased()) }
    }
}
