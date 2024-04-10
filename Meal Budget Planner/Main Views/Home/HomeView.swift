//
//  MyMealsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//
import Firebase
import SwiftUI

class MyMealsViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    
    init(){
        ref = Database.database().reference()
    }
    
    @Published var breakfastMeal : String = ""
    @Published var lunchMeal : String = ""
    @Published var dinnerMeal : String = ""
    
    func fetchUserBreakfastSelection() {
        
        var nOfUser = 0
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
            nOfUser = numberOfUsers - 1
            
            let userNum = "User \(nOfUser)"
            print(userNum)
            
            let ref = Database.database().reference().child("Users").child(userNum)
            
            ref.observeSingleEvent(of: .value) { snapshot in
                guard let userData = snapshot.value as? [String: Any] else {
                    print("Failed to fetch \(userNum) data")
                    return
                }
                
                if let breakfastSelection = userData["Breakfast Selection"] as? String {
                    self.breakfastMeal = breakfastSelection
                    print(self.breakfastMeal)
                    
                    // Move substring extraction inside this closure
                    if let index = breakfastSelection.firstIndex(of: ",") {
                        let substringBeforeComma = breakfastSelection[..<index]
                        print(substringBeforeComma)
                        self.breakfastMeal = String(substringBeforeComma)
                        print("breakfast meal: \(self.breakfastMeal)")
                    } else {
                        print("No comma")
                    }
                } else {
                    print("\(userNum) has no breakfast selection.")
                }
            }
        }
        
    }
    
    func fetchUserLunchSelection() {
        
        var nOfUser = 0
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
            nOfUser = numberOfUsers - 1
            
            let userNum = "User \(nOfUser)"
            print(userNum)
            
            let ref = Database.database().reference().child("Users").child(userNum)
            
            ref.observeSingleEvent(of: .value) { snapshot in
                guard let userData = snapshot.value as? [String: Any] else {
                    print("Failed to fetch \(userNum) data")
                    return
                }
                
                if let lunchSelection = userData["Lunch Selection"] as? String {
                    self.lunchMeal = lunchSelection
                    print(self.lunchMeal)
                    
                    // Move substring extraction inside this closure
                    if let index = lunchSelection.firstIndex(of: ",") {
                        let substringBeforeComma = lunchSelection[..<index]
                        print(substringBeforeComma)
                        self.lunchMeal = String(substringBeforeComma)
                        print("lunch meal: \(self.lunchMeal)")
                    } else {
                        print("No comma")
                    }
                } else {
                    print("\(userNum) has no breakfast selection.")
                }
            }
        }
        
    }
    
    func fetchUserDinnerSelection() {
        
        var nOfUser = 0
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
            nOfUser = numberOfUsers - 1
            
            let userNum = "User \(nOfUser)"
            print(userNum)
            
            let ref = Database.database().reference().child("Users").child(userNum)
            
            ref.observeSingleEvent(of: .value) { snapshot in
                guard let userData = snapshot.value as? [String: Any] else {
                    print("Failed to fetch \(userNum) data")
                    return
                }
                
                if let dinnerSelection = userData["Dinner Selection"] as? String {
                    self.dinnerMeal = dinnerSelection
                    print(self.dinnerMeal)
                    
                    // Move substring extraction inside this closure
                    if let index = dinnerSelection.firstIndex(of: ",") {
                        let substringBeforeComma = dinnerSelection[..<index]
                        print(substringBeforeComma)
                        self.dinnerMeal = String(substringBeforeComma)
                        print("dinner meal: \(self.dinnerMeal)")
                    } else {
                        print("No comma")
                    }
                } else {
                    print("\(userNum) has no breakfast selection.")
                }
            }
        }
        
    }
    
}

struct HomeView: View {
    
    enum Tab {
      case grocery, home, explore, favorites, settings
     }
    
    @State private var selectedTab: Tab = .home
    @State private var selectedDate = Date()

    let currentDate = Date()
    let calendar = Calendar.current
   
    var body: some View {
        
        
        NavigationView(){
            
            VStack{
                
                Spacer()
                CalendarView()
                    .padding(.top)
                // Spacer()
                // .padding(.bottom, 50)
                
                
                VStack(spacing: 0) {
                    MealButtonView(category: "B R E A K F A S T")
                    MealButtons(title: "Meal Name")
                    MealButtonView(category: "L U N C H")
                    MealButtons(title: "Meal Name")
                    MealButtonView(category: "D I N N E R ")
                    MealButtons(title: "Meal Name")
                }
                .padding(.bottom, 100)
                
                //Spacer()
                
                
            }
            .navigationBarTitle(Text("Home"))
            //.navigationBarHidden(true)
            
            Spacer()
            .navigationBarBackButtonHidden(true)
            }
        
        
        .edgesIgnoringSafeArea(.top)
        
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

