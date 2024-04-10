//
//  ExplorePageView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/6/24.
//
/*
import SwiftUI

struct ExplorePageView: View {
    
    @EnvironmentObject var recipeListViewModel: RecipeListViewModel
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    
                    // MARK: - HEADER
                    
                    HeaderView()
                    
                    // MARK: - CATEGORIES
                    
                    if self.recipeListViewModel.dataBfastLoading {
                        ActivityIndicator()
                            .frame(width:30, height: 30)
                            .foregroundColor(.orange)
                            .opacity(self.recipeListViewModel.dataBfastLoading ? 1.0 : 0.0)
                    } else {
                         RecipeRowView(categoryName: "Breakfast", recipes: recipeListViewModel.bfastRecipeData)
                        
                    }
                    
                    if self.recipeListViewModel.dataLunchLoading {
                        ActivityIndicator()
                           .frame(width:30, height: 30)
                           .foregroundColor(.orange)
                    } else {
                        RecipeRowView(categoryName: "Lunch", recipes: recipeListViewModel.lunchRecipeData)
                    }
                    if self.recipeListViewModel.dataDinnerLoading {
                        ActivityIndicator()
                           .frame(width:30, height: 30)
                           .foregroundColor(.orange)
                    } else {
                        RecipeRowView(categoryName: "Dinner", recipes: recipeListViewModel.dinnerRecipeData)
                    }
                    
                    
                    // MARK: - RECIPE CARDS
                    
                    Text("All Recipes")
                        .fontWeight(.bold)
                        .modifier(TitleModifier())
                    
                    VStack(alignment: .center, spacing: 20) {
                        
                        if self.recipeListViewModel.dataIsLoading {
                            ActivityIndicator()
                               .frame(width:30, height: 30)
                               .foregroundColor(.orange)
                        }
                        
                        ForEach(recipeListViewModel.recipeData) { item in
                            RecipeCardView(recipe: item)
                        }
                    }
                    .frame(maxWidth: 640)
                    .padding(.horizontal)
                    .padding(.bottom, 160)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .padding(0)
                
        }
    }

}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView()
    }
}
*/
