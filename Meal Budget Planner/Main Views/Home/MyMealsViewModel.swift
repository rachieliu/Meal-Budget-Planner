//
//  MyMealsViewModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/18/24.
//
/*
import Firebase
import SwiftUI

struct Meal {
   
    let name: String
    let id: String
    let imageURL: String
    /*
    init(id: String?, name: String, imageURL: String) {
        self.id = id ?? "0"
        self.name = name
        self.imageURL = imageURL
    }*/
}



class MyMealsViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    var currentDayIndex = 0
    
    init(){
        ref = Database.database().reference()
    }
    
    @Published var breakfastOptionsFromDatabase: [Meal] = []
    @Published var lunchOptionsFromDatabase: [Meal] = []
    @Published var dinnerOptionsFromDatabase: [Meal] = []
    @Published var breakfastMeal: Meal? = nil
    @Published var lunchMeal: Meal? = nil
    @Published var dinnerMeal: Meal? = nil
    
    //for meal name (title)
    @Published var breakfastMealTemp : String = ""
    @Published var lunchMealTemp : String = ""
    @Published var dinnerMealTemp : String = ""
   
    //for meal ID to show image
    @Published var breakfastMealID: String = ""
    @Published var lunchMealID: String = ""
    @Published var dinnerMealID: String = ""
    
    
    
    func mockFetchMealSelections(for date: Date) {
        // Get the current calendar and selected date components
        let calendar = Calendar.current
        let selectedDateComponents = calendar.dateComponents([.day], from: date)
        
        // Determine the index of the selected date relative to the current date
        let currentDateComponents = calendar.dateComponents([.day], from: Date())
        let dayDifference = calendar.dateComponents([.day], from: currentDateComponents, to: selectedDateComponents).day ?? 0
        
        let breakfastOptions = [
            Meal(name: "Breakfast Smoothie", id: "1", imageURL: "1"),
            Meal(name: "American Breakfast", id: "2", imageURL: "2"),
            Meal(name: "Peanut Butter Toast", id: "3", imageURL: "3")
        ]

        let lunchOptions = [
            Meal(name: "Turkey Sandwich", id: "4", imageURL: "4"),
            Meal(name: "Chipotle", id: "5", imageURL: "5"),
            Meal(name: "Salad", id: "6", imageURL: "6")
        ]

        let dinnerOptions = [
            Meal(name: "Tomato Soup", id: "7", imageURL: "7"),
            Meal(name: "Chicken and Cabbage Bowl", id: "8", imageURL: "8"),
            Meal(name: "Chicken Sandwich", id: "9", imageURL: "9")
        ]
       
        if dayDifference == 0 {
            // Today's meals
            breakfastMealTemp = breakfastOptions[0].name
            lunchMealTemp = lunchOptions[0].name
            dinnerMealTemp = dinnerOptions[0].name
            
            breakfastMealID = breakfastOptions[0].id
            lunchMealID = lunchOptions[0].id
            dinnerMealID = dinnerOptions[0].id
        } else if dayDifference == 1 {
            // Tomorrow's meals
            breakfastMealTemp = breakfastOptions[1].name
            lunchMealTemp = lunchOptions[1].name
            dinnerMealTemp = dinnerOptions[1].name
            
            breakfastMealID = breakfastOptions[1].id
            lunchMealID = lunchOptions[1].id
            dinnerMealID = dinnerOptions[1].id
        } else if dayDifference == 2 {
            // Meals after tomorrow
            breakfastMealTemp = breakfastOptions[2].name
            lunchMealTemp = lunchOptions[2].name
            dinnerMealTemp = dinnerOptions[2].name
            
            breakfastMealID = breakfastOptions[2].id
            lunchMealID = lunchOptions[2].id
            dinnerMealID = dinnerOptions[2].id
        }
    }

   // let options = ["Breakfast Selection", "Lunch Selection", "Dinner Selection"]
    
    func fetchMealSelections(for date: Date) {
        // Increment currentDayIndex whenever fetchMealSelections is called
        currentDayIndex += 1
        
        // Fetch breakfast options
        fetchUserMealSelection(for: "Breakfast Selection") { options in
            self.breakfastOptionsFromDatabase = options
            if !options.isEmpty {
                let index = self.currentDayIndex % options.count
                self.breakfastMeal = options[index]
               // self.breakfastMealID = options[index].id
            }
        }
        
        // Fetch lunch options
        fetchUserMealSelection(for: "Lunch Selection") { options in
            self.lunchOptionsFromDatabase = options
            if !options.isEmpty {
                let index = self.currentDayIndex % options.count
                self.lunchMeal = options[index]
               // self.lunchMealID = options[index].id
            }
        }
        
        // Fetch dinner options
        fetchUserMealSelection(for: "Dinner Selection") { options in
            self.dinnerOptionsFromDatabase = options
            if !options.isEmpty {
                let index = self.currentDayIndex % options.count
                self.dinnerMeal = options[index]
               // self.dinnerMealID = options[index].id
            }
        }
    }
/*
    private func fetchMealSelections(for mealOption: String, completion: @escaping ([Meal]) -> Void) {
        let userNum = UserManager.shared.userID
        let ref = Database.database().reference().child("Users").child(userNum)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userData = snapshot.value as? [String: Any],
                  let selection = userData[mealOption] as? String else {
                completion([])
                return
            }
            let mealNames = selection.components(separatedBy: ",")
            var meals: [Meal] = []
            
            // Create a dispatch group to synchronize asynchronous tasks
            let dispatchGroup = DispatchGroup()
            
            // Fetch meal ID for each meal name
            for mealName in mealNames {
                dispatchGroup.enter() // Enter the dispatch group
                
                // Get the mealID for the mealName
                self.getMealID(for: mealName) { mealID in
                    if let mealID = mealID {
                        // Create a Meal object with imageURL
                        let imageURL = mealID // Assuming mealID is the same as the image name in assets
                        let meal = Meal(id: mealID, name: mealName, imageURL: imageURL)
                        meals.append(meal)
                    }
                    
                    dispatchGroup.leave() // Leave the dispatch group
                }
            }
            
            // Notify when all tasks in the dispatch group are finished
            dispatchGroup.notify(queue: .main) {
                completion(meals)
            }
        }){(error) in
            print("Error: \(error.localizedDescription)")
            completion([])
            
        }
    }*/
    
    private func fetchUserMealSelection(for mealOption: String, completion: @escaping ([Meal]) -> Void) {
        
        //obtain current user's ID
        let userNum = UserManager.shared.userID
        
        //construct reference to the firebase realtime database location
        let ref = Database.database().reference().child("Users").child(userNum)
        
        //observe single event of type .value on this database reference
        ref.observeSingleEvent(of: .value) { snapshot in
            // Check if the snapshot contains valid data
            guard let userData = snapshot.value as? [String: Any],
            
                  let selection = userData[mealOption] as? String else{
                completion([])
                return
            }
           
        
            let mealNames = selection.components(separatedBy: ",")
            var meals: [Meal] = []
            
            //to synchronize asynchronous tasks
            let dispatchGroup = DispatchGroup()
            
            
            // Fetch meal ID for each meal name
            for mealName in mealNames {
                
                dispatchGroup.enter()
                
              
                self.getMealID(for: mealName) { mealID in
                    if let mealID = mealID {
                        let imageURL = mealID
                        let meal = Meal(name: mealName, id: mealID, imageURL: imageURL)
                        meals.append(meal)
                       
                        
                       /* if meals.count == mealNames.count{
                            completion(meals)
                        }*/
                    }
                    dispatchGroup.leave()
                }
            }
            
            
            // Notify when all tasks in the dispatch group are finished
            dispatchGroup.notify(queue: .main) {
                completion(meals)
            }
        }
    }

    private func getMealID(for mealName: String, completion: @escaping (String?) -> Void) {
       
        let mealref = Database.database().reference().child("MEALS") 
        // Query the database to find the meal ID for the given meal name
        mealref.queryOrdered(byChild: "Meal Name").queryEqual(toValue: mealName).observeSingleEvent(of: .value) { snapshot in
            if let value = snapshot.value as? [String: Any] {
                // If a match is found, retrieve the meal ID
                let mealID = value.keys.first
                completion(mealID)
            } else {
                // If no match is found, return nil
                completion(nil)
            }
        }
    }


    
  
}

*/
