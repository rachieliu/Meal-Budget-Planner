//
//  FavoritesView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/9/24.
//


import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteItems: [MealItem] = []
}
struct FavoritesView: View {
   // var favoriteItems: [MealItem]
    @EnvironmentObject var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.favoriteItems) { item in
                        
                        HStack {
                            Text(item.name) //meal name
                                .font(.headline)
                            Spacer() 
                            
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .cornerRadius(10)
                        }
                       
                    }
                }
                .padding()
            }
            .navigationBarTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = FavoritesViewModel()
        viewModel.favoriteItems = [
            MealItem(name: "Pasta", imageName: "1b5", isFavorite: true),
            MealItem(name: "Salad", imageName: "2b5", isFavorite: true),
            MealItem(name: "Pizza", imageName: "4l1", isFavorite: true)
        ]
        
        return FavoritesView()
            .environmentObject(viewModel)
    }
}
