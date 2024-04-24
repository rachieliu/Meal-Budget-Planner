//
//  MyMealsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//
import Firebase
import SwiftUI
struct Meal {
   
    let name: String
    let id: String
    let imageURL: String
    
}



class MyMealsViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    var currentDayIndex = 0
    
    // Define separate index variables for each meal category
    var currentBreakfastIndex = 0
    var currentLunchIndex = 0
    var currentDinnerIndex = 0
    
    init(){
        ref = Database.database().reference()
    }
    
    @Published var breakfastOptionsFromDatabase: [Meal] = []
    @Published var lunchOptionsFromDatabase: [Meal] = []
    @Published var dinnerOptionsFromDatabase: [Meal] = []
    //for meal name (title)
    @Published var breakfastMeal: String = ""
    @Published var lunchMeal: String = ""
    @Published var dinnerMeal: String = ""
   
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
            breakfastMeal = breakfastOptions[0].name
            lunchMeal = lunchOptions[0].name
            dinnerMeal = dinnerOptions[0].name
            
            breakfastMealID = breakfastOptions[0].id
            lunchMealID = lunchOptions[0].id
            dinnerMealID = dinnerOptions[0].id
        } else if dayDifference == 1 {
            // Tomorrow's meals
            breakfastMeal = breakfastOptions[1].name
            lunchMeal = lunchOptions[1].name
            dinnerMeal = dinnerOptions[1].name
            
            breakfastMealID = breakfastOptions[1].id
            lunchMealID = lunchOptions[1].id
            dinnerMealID = dinnerOptions[1].id
        } else if dayDifference == 2 {
            // Meals after tomorrow
            breakfastMeal = breakfastOptions[2].name
            lunchMeal = lunchOptions[2].name
            dinnerMeal = dinnerOptions[2].name
            
            breakfastMealID = breakfastOptions[2].id
            lunchMealID = lunchOptions[2].id
            dinnerMealID = dinnerOptions[2].id
        }
        else {
            let numberOfOptions = min(breakfastOptions.count, lunchOptions.count, dinnerOptions.count)
            for i in 0..<dayDifference {
                let index = i % numberOfOptions

                breakfastMeal = breakfastOptions[index].name
                lunchMeal = lunchOptions[index].name
                dinnerMeal = dinnerOptions[index].name
                
                breakfastMealID = breakfastOptions[index].id
                lunchMealID = lunchOptions[index].id
                dinnerMealID = dinnerOptions[index].id
            }
            
        }

       
      
    }
    

   // let options = ["Breakfast Selection", "Lunch Selection", "Dinner Selection"]
    
    private func fetchMealSelections(for date: Date) {
        // Increment currentDayIndex whenever fetchMealSelections is called
        currentDayIndex += 1
        
        // Reset meal indices to 0 when fetching new selections
        currentBreakfastIndex = 0
        currentLunchIndex = 0
        currentDinnerIndex = 0
        
        // Fetch breakfast options
        fetchUserMealSelection(for: "Breakfast Selection", for: date) { options in
            self.breakfastOptionsFromDatabase = options
            if !options.isEmpty {
                let index = self.currentDayIndex % options.count
                self.breakfastMeal = options[index].name
                self.breakfastMealID = options[index].id
                self.currentBreakfastIndex = index
            }
        }
        
        // Fetch lunch options
        fetchUserMealSelection(for: "Lunch Selection", for: date) { options in
            self.lunchOptionsFromDatabase = options
            if !options.isEmpty {
                let index = self.currentDayIndex % options.count
                self.lunchMeal = options[index].name
                self.lunchMealID = options[index].id
                self.currentLunchIndex = index // Update lunch index
            }
        }
        
        // Fetch dinner options
        fetchUserMealSelection(for: "Dinner Selection", for: date) { options in
            self.dinnerOptionsFromDatabase = options
            if !options.isEmpty {
                let index = self.currentDayIndex % options.count
                self.dinnerMeal = options[index].name
                self.dinnerMealID = options[index].id
                self.currentDayIndex = index // Update lunch index
            }
        }
    }
    private func fetchUserMealSelection(for mealOption: String, for date: Date, completion: @escaping ([Meal]) -> Void) {
        
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
        let mealRef = Database.database().reference().child("MEALS")
        
        // Query the database to find the meal ID for the given meal name
        mealRef.observeSingleEvent(of: .value) { snapshot in
            if let meals = snapshot.value as? [[String: Any]] {
                for meal in meals {
                    if let name = meal["Meal Name"] as? String {
                        // Trim whitespace from the query meal name
                        let trimmedQueryMealName = mealName.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        // Trim whitespace from the database meal name and perform comparison
                        if let trimmedDatabaseMealName = (name as? String)?.trimmingCharacters(in: .whitespacesAndNewlines), trimmedDatabaseMealName.caseInsensitiveCompare(trimmedQueryMealName) == .orderedSame {
                            // If a match is found, retrieve the meal ID
                            if let mealID = meal["Meal ID"] as? Int {
                                let mealIDString = String(mealID)
                                print("Meal ID for \(trimmedQueryMealName) is \(mealIDString)")
                                completion(mealIDString)
                                return
                            }
                        }
                    }
                }
            }
            // If no match is found, print a message and call the completion handler with nil
            print("Meal ID not found for \(mealName)")
            completion(nil)
        }
    }


    func fetchMealSelectionsAndUpdateView(for date: Date) {
     
        fetchMealSelections(for: date)
    }

   

    
  
}



struct HomeView: View {
    
    @StateObject var viewModel = MyMealsViewModel()
    @State private var selectedDate = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack {
                    Spacer()
                    CalendarView(selectedDate: $selectedDate, viewModel: viewModel)
                        .padding(.top, 0)
                    
                     
                    VStack(spacing: 0) {
                        
                         VStack(spacing: 0) {
                         MealButtonView(category: "Breakfast ")
                                 .padding(.bottom, 30)
                               
                                 
                             MealButtons(title: viewModel.breakfastMeal, mealID: viewModel.breakfastMealID)
                         MealButtonView(category: "Lunch")
                                 .padding(.bottom, 30)
            
                               
                             MealButtons(title: viewModel.lunchMeal, mealID: viewModel.lunchMealID)
                             
                         MealButtonView(category: "Dinner")
                          
                                 .padding(.bottom, 30)
                          
                            
                             MealButtons(title: viewModel.dinnerMeal, mealID: viewModel.dinnerMealID)
                                 
                         }
                         .padding(.bottom,60)
                            
                    }
                    
                    .navigationBarTitle(Text("Home"))
                    .background(Color("white"))
                    
                    .edgesIgnoringSafeArea(.top)
                }
                /*---------------For DEMO  -----------------------------------------*/
                /*
                .onAppear {
                    viewModel.fetchMealSelectionsAndUpdateView(for: selectedDate)
                }*/
              
                /*---------------For Preview Environment -----------------------------------------*/
                .onAppear {
                  
                    #if DEBUG
                    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                        // Simulate fetching mock meal selections after a delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            viewModel.mockFetchMealSelections(for: selectedDate)
                        }
                        return
                    }
                    #endif
                    
                    // Fetch meal selections from the database
                    viewModel.fetchMealSelectionsAndUpdateView(for: selectedDate)
                }
               
            
            }
            .background(Color("Ivory"))
            
            
            
            
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
 
        Group {
             HomeView()
                .previewInterfaceOrientation(.portrait)
             HomeView()
                 .previewInterfaceOrientation(.portraitUpsideDown)
         }
     
    }
}
