//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI


struct MealItemView: View {
    
    @ObservedObject var viewModel = ExploreViewModel()

    let mealItem: MealItem
    @Binding var isExpanded: Bool
    @Binding var isFavorite: Bool

    
    var body: some View {
        VStack {
            
            ZStack(alignment: .topLeading) {
                // Meal image
                Image(mealItem.imageName)
                    .resizable()
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(width: 180, height: isExpanded ? 250 : CGFloat.random(in: 180...250), alignment: .center)
                    .overlay(
                        Button(action: {
                              isExpanded.toggle()
                          }) {
                              Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                  .foregroundColor(.white)
                                  .padding(8)
                                  .background(Color.black.opacity(0.5))
                                  .clipShape(Circle())
                                  .padding(8)
                          }
                          .offset(x: 60, y: 0), // Adjust the offset for proper positioning
                          alignment: .top // Align the overlay to the top of the image
                    )
                
                
                // Heart icon
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                          .foregroundColor(isFavorite ? Color("FavoritesClick") : .gray)
                          .padding(5)
                          .background(Color.white.opacity(0.8))
                          .clipShape(Circle())
                          .overlay(Circle().stroke(Color.gray.opacity(0.5), lineWidth: 0.5))
                }
                .padding(10)
                .offset(x: -4, y: -4)
            }
            if isExpanded {
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        Text("Meal Details")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Text("Description goes here...")
                            .font(.subheadline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
          
            
        }
            
    }
    private func toggleFavorite() {
         isFavorite.toggle()
         if isFavorite {
             print("Meal added to favorites: \(mealItem.name)")
         } else {
             print("Meal removed from favorites: \(mealItem.name)")
         }
     }
}


struct MealItemView_Previews: PreviewProvider {
    static var previews: some View {
        let mealItem = MealItem(name: "Your Meal Name", imageName: "yourImageName", isFavorite: false)
        let mealItemState = MealItemViewState(isExpanded: false, isFavorite: false)
        return MealItemView(mealItem: mealItem, isExpanded: .constant(mealItemState.isExpanded), isFavorite: .constant(mealItemState.isFavorite))
    }
}


