
//
//  BreakfastSelectView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI
import Firebase


class MealSelectionViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    var userBudget = 0
    
    init(){
        ref = Database.database().reference()
    }
    
    @Published var selectedMeals: Set<String> = Set()
    @Published var showAlert: Bool = false
    @Published var mealOptions: [String: (id: String, recipe: String, calories: String)] = [:]
    @Published var isLoading: Bool = false
    
    //function so that if users select more than 3 an alert will show
    func toggleMealSelection(_ meal: String) {
        if selectedMeals.contains(meal) {
            selectedMeals.remove(meal)
        } else if selectedMeals.count < 3 {
            selectedMeals.insert(meal)
        }else {
            showAlert = true
        }
        
        print(selectedMeals)
    }
    
    func dismissAlert() {
            showAlert = false
        }
    
    
    
    //functino to get 
    func getBreakfastMeals() {
        mealOptions.removeAll()
        let userNum = UserManager.shared.userID
        print("U: \(userNum)")
        
        //get users budget Selection
        let userBudgetRef = ref.child("Users").child(userNum).child("Budget")
        // Retrieve the value of the budget
        userBudgetRef.observeSingleEvent(of: .value) { (snapshot) in
            if let budget = snapshot.value as? Int {
                print("\(userNum)'s budget is: \(budget)")
                self.userBudget = budget
            } else {
                print("Budget not found for \(userNum)")
            }
        }
        
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
                    
                    // Check if the meal's budget matches the user's budget
                    if mealBudget == self.userBudget {
                        print("Meal ID: \(mealID), Meal Name: \(mealName), Recipe: \(recipeName), total Calories: \(totalCalories)")
                        
                        
                        DispatchQueue.main.async{
                            self.mealOptions[mealName] = (id: String(mealID), recipe: recipeName, calories: String(totalCalories))
                            //self.mealOptions[mealName] = String(mealID)
                            
                        }
                    }
                }
                self.isLoading = false // Set loading state to false after meals are fetched
            }
    }
    
    func storeSelectedMeals(selectedMeals: Set<String>) {
        // Create a variable to keep track of the count of matched selections
        var matchedSelectionsCount = 0
        
        // Iterate through each selected meal
        for selectedMeal in selectedMeals {
            // Check if the selected meal matches any of the offered options exactly
            if mealOptions.keys.contains(selectedMeal) {
                // Increment the count of matched selections
                matchedSelectionsCount += 1
            }
        }
        
        // Check if all three selections are matched exactly
        if matchedSelectionsCount == 3 {
            // All selections are valid, proceed to store them
            var nOfUser = 0
            let breakfast = selectedMeals.joined(separator: ", ")
            let userRef = ref.child("Users")
            
            userRef.observeSingleEvent(of: .value) { (snapshot) in
                guard snapshot.exists(), let usersDict = snapshot.value as? [String: Any] else {
                    print("No data found under Users node")
                    return
                }
                
                let numberOfUsers = usersDict.count
                print("Number of users: \(numberOfUsers)")
                nOfUser = numberOfUsers - 1
                
                let userNum = "User "  + String(nOfUser)
                
                self.ref.child("Users").child(userNum).updateChildValues(["Breakfast Selection": breakfast])
            }
        } else {
            // If not all selections match exactly, display an alert
            showAlert = true
        }
    }    
    
    /*
    func getRecipeDetails(for mealID: String) {
        
        
        ref.child("Meal ID").child(mealID).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let recipeData = snapshot.value as? [String: Any]
                self.recipeName = recipeData?["Recipe"] as? String ?? "Unknown"
                self.totalCalories = recipeData?["Total Calories"] as? Int ?? 0
            } else {
                print("Recipe details not found for meal ID: \(mealID)")
            }
        }
    }*/


    
}


struct BreakfastSelectView: View {
    @ObservedObject var viewModel = MealSelectionViewModel()
    //@ObservedObject var mockviewModel = MockMealSelectionViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   // @State private var screenWidth: CGFloat = UIScreen.main.bounds.width
    
 
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                            
                        } label: {
                            Image(systemName: "arrowshape.backward.fill")
                        }
                        .font(.system(size:20))
                        .foregroundColor(Color("GreenBlue"))
                        
                        
                        .padding(.leading,10)
                        
                        .padding(.trailing,300)
                        
                    }
                    Spacer()
                    
            
                    VStack(spacing: 15){
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color("PrimaryColor"))
                                .cornerRadius(20)
                                .padding(.horizontal, 10)
                                .frame(height: 60)
                            Text("Let's plan your meals for the week")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .padding()
                        }
                        
                        
                        HStack(spacing: 3){
                            Text("Select 3 Meals for Breakfast")
                                .foregroundColor(Color("PrimaryColor"))
                                .fontWeight(.bold)
                                .font(.system(size:25))
                        }
                        
                    
                    }
                    .padding(.bottom, 50)
                 
                    
                    
                    ScrollView(.horizontal){
                        HStack(spacing:20){
                            ForEach(viewModel.mealOptions.keys.sorted(), id: \.self) { mealName in
                                if let mealInfo = viewModel.mealOptions[mealName] {
                                    let id = mealInfo.id
                                    let recipe = mealInfo.recipe
                                    let calories = mealInfo.calories
                                    
                                    ExpandableView(thumbnail: ThumbnailView {
                                        VStack() {
                                            Text(mealName)
                                                .frame(width: 200, height: 50)
                                                .foregroundColor(Color("Chocolate"))
                                                .font(.custom("ArialRoundedMTBold", size: 20))
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.white)
                                                )
                                                .padding(.horizontal, 30)
                                                .padding(.top, 30)
                                            Image(id)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 250, height: 250)
                                                .padding(.horizontal)
                                                .padding(.top)
                                                .padding(.bottom)
                                        }
                                        .padding(.bottom)
                                    }, expanded: ExpandedView{
                                        VStack(spacing:10) {
                                            Image(id)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: .infinity, maxHeight: 100)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(viewModel.selectedMeals.contains(mealName) ? Color.clear : Color.clear, lineWidth: 2)
                                                )
                                            Text(mealName)
                                                .frame(maxWidth: .infinity,maxHeight: 50, alignment: .center)
                                                .foregroundColor(Color("Chocolate"))
                                                .font(.custom("ArialRoundedMTBold", size: 20))
                                                .background(
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .fill(Color.white)
                                                )
                                                .padding(.horizontal)
                                            
                                            Text("Recipe: \(recipe)")
                                                .frame(maxWidth:300, alignment: .center)
                                                .foregroundColor(.black)
                                                .font(.system(size: 18))
                                                .padding(.horizontal)
                                            
                                            Text("Calories: \(calories)")
                                                .foregroundColor(.black)
                                                .font(.system(size: 18))
                                                .padding(.horizontal)
                                            Spacer()
                                        }
                                        .padding()
                                        /*.onAppear {
                                            viewModel.getRecipeDetails(for: id)
                                        }*/
                                    }, thumbnailViewBackgroundColor: Color("GreyTone").opacity(0.7), expandedViewBackgroundColor: Color("BabyBlue"))
                                    .padding(.leading, 10)
                                    
                                    Button(action: {
                                        viewModel.toggleMealSelection(mealName)// Toggle the selection state when tapped
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .foregroundStyle(viewModel.selectedMeals.contains(mealName) ? Color.teal : Color.gray)
                                    }
                                    .padding(.top, 300)
                                    .padding(.leading, -90)
                                }
                            }
                            .padding(.horizontal, 7)
                    }
                      
                
                }
                    
                    
                    Text("Selected meals: \(viewModel.selectedMeals.joined(separator: ", "))")
                                    .padding()
                                    .foregroundColor(.black)
                    
                    Button("Show Alert") {
                        viewModel.showAlert = true
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text("Alert"),
                            message: Text("Invalid input. You can only select up to 3 meals. Please deselect a meal to select another"),
                            dismissButton: .default(Text("OK")) {
                                viewModel.dismissAlert()
                            }
                        )
                    }
                    //.padding(.top, 20)
                    .opacity(viewModel.selectedMeals.count <= 3 ? 0 : 1)
                    
                    NavigationLink(
                        destination:
                            LunchSelectView().onAppear(){
                                viewModel.storeSelectedMeals(selectedMeals: viewModel.selectedMeals)
                            }
                            .navigationBarHidden(true),
                        label:{

                            Image(systemName: "arrow.right")
                            
                        
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        
                        
                    })
                    .background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 300, bottom: 20, trailing: 20))
                      
                }
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                }
                
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+1){
                viewModel.getBreakfastMeals()
            }
        }
    }
}




struct BreakfastSelectView_Previews: PreviewProvider {
    static var previews: some View {
    

        // Pass the viewModel as a parameter to BreakfastSelectView
        BreakfastSelectView(viewModel: MealSelectionViewModel())
    }
}

