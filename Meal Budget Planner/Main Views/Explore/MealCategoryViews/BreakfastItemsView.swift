//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.



import Foundation
import Firebase


class ExploreViewModel: ObservableObject{
    
    var ref: DatabaseReference!
    
    
    init(){
        ref = Database.database().reference()
    }
    
    @Published var mealOptions: [String: (id: String, recipe: String, calories: String)] = [:]
    
    
    func getBreakfastMeals() {
        mealOptions.removeAll()
        let userNum = UserManager.shared.userID
        print("U: \(userNum)")
        
        
        
        let mealref = Database.database().reference().child("MEALS")
            
            // Query meals with type "Breakfast"
            mealref.queryOrdered(byChild: "Type").queryEqual(toValue: "Breakfast").observeSingleEvent(of: .value) { (snapshot) in
                guard snapshot.exists() else {
                    print("No meals found for type 'Breakfast'")
                    return
                }
                
                for child in snapshot.children {
                    let mealSnapshot = child as! DataSnapshot
                    let mealID = mealSnapshot.childSnapshot(forPath: "Meal ID").value as? Int ?? 0
                    let mealName = mealSnapshot.childSnapshot(forPath: "Meal Name").value as? String ?? "Unknown"
                    let recipeName = mealSnapshot.childSnapshot(forPath: "Recipe").value as? String ?? "Unknown"
                    let totalCalories = mealSnapshot.childSnapshot(forPath: "Total Calories ").value as? Int ?? 0
                    
                    let mealBudget = mealSnapshot.childSnapshot(forPath: "Budget").value as? Int ?? 0
                    
                   
                        
                        
                    DispatchQueue.main.async{
                        self.mealOptions[mealName] = (id: String(mealID), recipe: recipeName, calories: String(totalCalories))
                        //self.mealOptions[mealName] = String(mealID)
                        
                    }
                    
                }
                // Set loading state to false after meals are fetched
            }
    }
    
}

//
import SwiftUI

struct MealItemViewState {
    var isExpanded: Bool = false
    var isFavorite: Bool = false
}

struct BreakfastItemsView: View {
    //@ObservedObject var viewModel = ExploreViewModel()
    let breakfastImageNames = ["1b1", "1b2", "1b3", "1b4", "1b5", "2b1", "2b2", "2b3", "2b4", "2b5"]
    let breakfastImagesNames2 = ["3b1", "3b2", "3b3", "3b4", "3b5", "4b1", "4b2", "4b3", "4b4", "4b5"] // Changed image names
    
    @State private var mealItemStates: [MealItemViewState] = Array(repeating: MealItemViewState(), count: 20)
    //@State private var favoriteItems: [MealItem] = []
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Display meal images
                    HStack(alignment: .top) {
                        
                        // First set of meal images
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<breakfastImageNames.count, id: \.self) { index in
                                let mealItem = MealItem(name: "Breakfast \(index)", imageName: breakfastImageNames[index], isFavorite: self.mealItemStates[index].isFavorite) // Create a MealItem instance
                                MealItemView(mealItem: mealItem, isExpanded: self.$mealItemStates[index].isExpanded, isFavorite: self.$mealItemStates[index].isFavorite)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Second set of meal images
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<breakfastImagesNames2.count, id: \.self) { index in
                                let realIndex = index + breakfastImageNames.count
                                let mealItem = MealItem(name: "Breakfast \(index)", imageName: breakfastImagesNames2[index], isFavorite: self.mealItemStates[realIndex].isFavorite)
                                MealItemView(mealItem: mealItem, isExpanded: self.$mealItemStates[realIndex].isExpanded, isFavorite: self.$mealItemStates[realIndex].isFavorite)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    
                    Spacer()
                }
            }
           
        }
    }
}
   
struct BreakfastItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        BreakfastItemsView()
    }
}
