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
                print("No dinner meals found")
            }
        }
    }
    
    func storeSelectedMeals(selectedMeals : Set<String>){
        
        var nOfUser = 0
        let lunch = selectedMeals.joined(separator: ", ")
        
        
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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image(systemName: "arrowshape.backward.fill")
                    }
                    .font(.system(size:20))
                    .foregroundColor(.orange)
                    
                    
                    .padding(.leading,10)
                    
                    .padding(.trailing,300)
            
                    
            
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
                            ForEach(viewModel.mealOptions.keys.sorted(),id: \.self){ meal in
                                ExpandableView(thumbnail: ThumbnailView {
                                    
                                    VStack() {
                                        Image(viewModel.mealOptions[meal]!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 150, height: 300)
                                        Text(meal)
                                            .frame(alignment: .leading)
                                              .foregroundColor(Color("Color1"))
                                              .font(.custom("ArialRoundedMTBold", size: 20))
                                    }
                                    .padding()
                                },expanded: ExpandedView{
                                    VStack(spacing:10) {
                                        Image(viewModel.mealOptions[meal]!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            
                                        Text(meal)
                                              .frame(maxWidth: .infinity, alignment: .leading)
                                              .foregroundColor(Color("PrimaryColor"))
                                              .font(.custom("ArialRoundedMTBold", size: 28))
                                          
                                          /*Text(mealData)
                                              .font(.custom("ArialRoundedMTBold", size: 14))
                                              .foregroundColor(Color("PrimaryColor"))*/
                                          
                                          Text("ooooo food yum yum")
                                              .font(.custom("ArialRoundedMT", size: 14))
                                              .foregroundColor(Color("PrimaryColor"))
                                        
                                        Spacer()
                                    }
                                    .padding()
                                }, thumbnailViewBackgroundColor: Color("Gray").opacity(0.7), expandedViewBackgroundColor: Color("Gray"))
                                Button(action: {
                                    viewModel.toggleMealSelection(meal)// Toggle the selection state when tapped
                                    
                                }){
                                    Image(systemName:"plus.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(viewModel.selectedMeals.contains(meal) ? Color.teal : Color.gray)
                                        
                                        
                                    
           
                                }
                                .padding(.trailing, -30)
                                
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
                            TabBarView().onAppear(){
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
