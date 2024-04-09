//
//  BreakfastSelectView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI
import Firebase

class DinnerSelectionViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    
    init(){
        ref = Database.database().reference()
    }
    
    @Published var selectedMeals: Set<String> = Set()
    @Published var showAlert: Bool = false
    @Published var mealOptions: [String: String] = [:]

    func toggleMealSelection(_ meal: String) {
        if selectedMeals.contains(meal) {
            selectedMeals.remove(meal)
        } else if selectedMeals.count < 3 {
            selectedMeals.insert(meal)
        }else {
            showAlert = true
        }
    }
    func dismissAlert() {
            showAlert = false
        }
    
    func getDinnerMeals() {
        ref.child("MEALS").queryOrdered(byChild: "Type").queryEqual(toValue: "Breakfast").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                // Iterate through each child snapshot to access individual meals
                for child in snapshot.children {
                    let mealSnapshot = child as! DataSnapshot
                    let mealID = mealSnapshot.key
                    let mealName = mealSnapshot.childSnapshot(forPath: "Meal Name").value as? String ?? "Unknown"
                    //let mealData = mealSnapshot.value as! [String: Any]
                    
                    // Here you can process each breakfast meal as needed
                    print("Meal ID: \(mealID)")
                    print("Meal Name: \(mealName)")
                    //print("Meal Data: \(mealData)")
                    
                    //self.selectedMeals.insert(mealName)
                    DispatchQueue.main.async{
                        self.mealOptions[mealName] = mealID
                    }
                    
                    
                }
            } else {
                print("No lunch meals found")
            }
        }
    }
    
    func storeSelectedMeals(selectedMeals : Set<String>){
        
        var nOfUser = 0
        var lunch = selectedMeals.joined(separator: ", ")
        
        
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
            
            self.ref.child("Users").child(userNum).updateChildValues(["Dinner Selection": lunch ])
        }
            
            
        
    }
}


struct DinnerSelectView: View {
    @ObservedObject var viewModel = DinnerSelectionViewModel()
    
    let mealOptions = [
            "Protein Smoothie": "proteinsmoothie",
            "Bagel": "bfastbagel",
            "Burrito": "bfastburrito",
            "Oatmeaal": "oatneal",
            "Avocado Toast": "avocadotoast"
        ]
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    Image("Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width:150, height: 100)
                        .padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
            
                    
            
                    VStack(spacing: 15){
                        Text("Let's plan your meals for the week")
                        HStack(spacing: 3){
                            Text("Select 3 Meals for Dinner")
                                .foregroundColor(Color("SecondaryColor"))
                                .fontWeight(.bold)
                                .font(.system(size:25))
                        }
                        
                    
                    }
                    .padding(.bottom, 50)
                 
                    
                    
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(mealOptions.keys.sorted(),id: \.self){ meal in
                                Button(action: {
                                    viewModel.toggleMealSelection(meal)
                                }) {
                                    Image(mealOptions[meal]!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 300)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(viewModel.selectedMeals.contains(meal) ? Color.blue : Color.clear, lineWidth: 2)
                                        )
                                }
                                
                        }
                        
                  
                            
                    }
                
                }
                    
                    Text("Selected meals: \(viewModel.selectedMeals.joined(separator: ", "))")
                                    .padding()
                    Button("Show Alert") {
                        viewModel.showAlert = true
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text("Alert"),
                            message: Text("You can only select up to 3 meals. Please deselect a meal to select another"),
                            dismissButton: .default(Text("OK")) {
                                viewModel.dismissAlert()
                            }
                        )
                    }
                    .padding(.top, 20)
                    .opacity(viewModel.selectedMeals.count <= 3 ? 0 : 1)
                    
                    NavigationLink(
                        destination:
                            MyMealsView().onAppear(){
                                viewModel.storeSelectedMeals(selectedMeals: viewModel.selectedMeals)
                            }
                            .navigationBarHidden(true),
                        label:{

                            Image(systemName: "arrow.right")
                            
                        
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        
                        
                    })
                    .background(Color("SecondaryColor"))
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 300, bottom: 20, trailing: 20))
                                    
            }
            }
        }.onAppear{viewModel.getDinnerMeals()}
}
}

struct DinnerSelectView_Previews: PreviewProvider {
    static var previews: some View {
    

        // Pass the viewModel as a parameter to BreakfastSelectView
        DinnerSelectView(viewModel: DinnerSelectionViewModel())
    }
}
