//
//  ExploreViewModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/23/24.
//

/*import Foundation
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
    
}*/
