//
//  BudgetSelectViewModel.swift
//  Meal Budget Planner
//
//  Created by Oscar Navarro on 2/23/24.
//

import Foundation
import Firebase

class BudgetSelectViewModel: ObservableObject{
    
    
    var ref: DatabaseReference!
    
    init(){
        ref = Database.database().reference()
    }
    
    
    

    
    
    func pushNewBudget(budget75:Bool,budget100:Bool,budget125:Bool,budget150:Bool){
        
        var nOfUser = 0
        var budget = 0
        
        let userRef = ref.child("Users")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
                    // Check if the snapshot exists and contains data
                    guard snapshot.exists(), let usersDict = snapshot.value as? [String: Any] else {
                        print("No data found under Users node")
                        return
                    }
                    
                    // Get the count of child nodes under "Users"
                    let numberOfUsers = usersDict.count
                    print("Number of users: \(numberOfUsers)")
                    nOfUser = numberOfUsers-1
            
                    let userNum = "User "  + String(nOfUser)
            
            guard budget75 || budget100 || budget125 || budget150 else {
                print("No budget option selected")
                return
            }
            
            // Validate that only one budget option is selected
            guard [budget75, budget100, budget125, budget150].filter({ $0 }).count == 1 else {
                print("Multiple budget options selected")
                return
            }
            
            
            if(budget75 == true){
                budget = 75
            }
            if(budget100 == true){
                budget = 100
            }
            if(budget125 == true){
                budget = 125
            }
            if(budget150 == true){
                budget = 150
            }

            
            self.ref.child("Users").child(userNum).updateChildValues(["Budget":budget ])
            
                }
        
    }
    
    
}
