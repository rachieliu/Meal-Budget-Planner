//
//  BreakfastSelectView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

class MealSelectionViewModel: ObservableObject {
    
    @Published var selectedMeals: Set<String> = Set()
    @Published var showAlert: Bool = false
    
    
    //function so that if users select more than 3 an alert will show
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
}


struct BreakfastSelectView: View {
    @ObservedObject var viewModel = MealSelectionViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let mealOptions = [
            "Protein Smoothie": "proteinsmoothie",
            "Bagel": "bfastbagel",
            "Burrito": "bfastburrito",
            "Oatmeaal": "oatneal",
            "Avocado Toast": "avocadotoast"
        ]
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                HStack{
                    Button("go back") {
                        self.presentationMode.wrappedValue.dismiss()
                    
                            
                        
                    }
                    .padding(.leading,10)
                    .padding(.bottom,80)
                    Spacer()
                    Image("Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width:150, height: 100)
                        .padding(.trailing,115)
                }
                
                .padding(.top,100)
                
        
                VStack(spacing: 15){
                    Text("Let's plan your meals for the week")
                    HStack(spacing: 3){
                        Text("Select 3 Meals for Breakfast")
                            .foregroundColor(Color("PrimaryColor"))
                            .fontWeight(.bold)
                            .font(.system(size:25))
                    }
                    
                
                }
               // .padding(.bottom)
             
                
                
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
                ZStack{
                    NavigationLink(
                        destination:
                            LunchSelectView().navigationBarHidden(true),
                        label:{

                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                                .opacity(viewModel.selectedMeals.count == 3 ? 1 : 0.6)
                            
                        
                        
                        
                        
                        }
                    )
                  
                    .background(Color("PrimaryColor").opacity(viewModel.selectedMeals.count == 3 ? 1 : 0.6))
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: -50, leading: 300, bottom: 100, trailing: 20))
                    .disabled(viewModel.selectedMeals.count != 3)
                }
                //.navigationBarBackButtonHidden(true)
                
            }
            .navigationBarBackButtonHidden(true)
            
            .edgesIgnoringSafeArea(.top)
        }
}
}

struct BreakfastSelectView_Previews: PreviewProvider {
    static var previews: some View {
    

        // Pass the viewModel as a parameter to BreakfastSelectView
        BreakfastSelectView(viewModel: MealSelectionViewModel())
    }
}
