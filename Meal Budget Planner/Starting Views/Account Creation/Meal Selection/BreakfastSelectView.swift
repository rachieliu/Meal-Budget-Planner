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
    
    init(){
        ref = Database.database().reference()
    }
    
    @Published var selectedMeals: Set<String> = Set()
    @Published var showAlert: Bool = false
    @Published var mealOptions: [String: String] = [:]
    
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
    
    
    func getBreakfastMeals() {
        ref.child("MEALS").queryOrdered(byChild: "Type").queryEqual(toValue: "Breakfast").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                // Iterate through each child snapshot to access individual meals
                for child in snapshot.children {
                    let mealSnapshot = child as! DataSnapshot
                    let mealID = mealSnapshot.key
                    let mealName = mealSnapshot.childSnapshot(forPath: "Meal Name").value as? String ?? "Unknown"
                  //  let mealData = mealSnapshot.value as! [String: Any]
                    
                    // Here you can process each breakfast meal as needed
                    print("Meal ID: \(mealID)")
                    print("Meal Name: \(mealName)")
                   // print("Meal Data: \(mealData)")
                    
                    //self.selectedMeals.insert(mealName)
                    DispatchQueue.main.async{
                        self.mealOptions[mealName] = mealID
                    }
                    
                    
                }
            } else {
                print("No breakfast meals found")
            }
        }
    }
    
    func displayMealDetails(){
        
    }
    

    
}


struct BreakfastSelectView: View {
    @ObservedObject var viewModel = MealSelectionViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
 
    
    var body: some View {
        NavigationView{
            ZStack {
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
                            Text("Select 3 Meals for Breakfast")
                                .foregroundColor(Color("PrimaryColor"))
                                .fontWeight(.bold)
                                .font(.system(size:25))
                        }
                        
                    
                    }
                    .padding(.bottom, 50)
                 
                    
                    
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(viewModel.mealOptions.keys.sorted(),id: \.self){ meal in
                                ExpandableView(thumbnail: ThumbnailView {
                                    
                                    HStack() {
                                        Image(viewModel.mealOptions[meal]!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 150, height: 300)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(viewModel.selectedMeals.contains(meal) ? Color.blue : Color.clear, lineWidth: 2)
                                            )
                                    }
                                    .padding()
                                }, expanded: ExpandedView{
                                    VStack(spacing:10) {
                                        Image(viewModel.mealOptions[meal]!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(viewModel.selectedMeals.contains(meal) ? Color.blue : Color.clear, lineWidth: 2)
                                            )
                                        Text(meal)
                                              .frame(maxWidth: .infinity, alignment: .leading)
                                              .foregroundColor(Color("PrimaryColor"))
                                              .font(.custom("ArialRoundedMTBold", size: 28))
                                          
                                          /*Text(mealData)
                                              .font(.custom("ArialRoundedMTBold", size: 14))
                                              .foregroundColor(Color("PrimaryColor"))*/
                                          
                                          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                              .font(.custom("ArialRoundedMT", size: 14))
                                              .foregroundColor(Color("PrimaryColor"))
                                        
                                        Spacer()
                                    }
                                    .padding()
                                }, thumbnailViewBackgroundColor: Color("Gray").opacity(0.7), expandedViewBackgroundColor: Color("Gray"))
                                
                                /*Button(action: {
                                    viewModel.toggleMealSelection(meal)
                                })
                                {
                                    Image(viewModel.mealOptions[meal]!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 150, height: 300)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(viewModel.selectedMeals.contains(meal) ? Color.blue : Color.clear, lineWidth: 2)
                                        )
                                }*/
                                
                        }
                        
                  
                            
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
                            LunchSelectView()
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
                
            }
        }.onAppear{ viewModel.getBreakfastMeals()}
}
}

struct BreakfastSelectView_Previews: PreviewProvider {
    static var previews: some View {
    

        // Pass the viewModel as a parameter to BreakfastSelectView
        BreakfastSelectView(viewModel: MealSelectionViewModel())
    }
}
