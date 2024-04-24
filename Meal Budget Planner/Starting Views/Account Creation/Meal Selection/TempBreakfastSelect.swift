
//
//  BreakfastSelectView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/20/24.
//

//temp file for designing the selection screens

import SwiftUI
import Firebase

class MockMealSelectionViewModel: ObservableObject {
    @Published var selectedMeals: Set<String> = []
    
    @Published var mealOptions: [String: String] = [
        "Eggs": "1", 
        "Oatmeal": "2",
        "Smoothie": "3",
        "Pancakes": "4",
        "Toast": "5"
    ]
    
    @Published var showAlert: Bool = false
    @Published var recipeName: String = ""
    @Published var totalCalories: Int = 0
    
    func toggleMealSelection(_ meal: String) {
        if selectedMeals.contains(meal) {
            selectedMeals.remove(meal)
        } else if selectedMeals.count < 3 {
            selectedMeals.insert(meal)
        } else {
            showAlert = true
        }
    }
    
    func dismissAlert() {
        showAlert = false
    }
    
    func storeSelectedMeals(selectedMeals: Set<String>) {
        // Mock implementation for storing selected meals
        print("Selected meals stored:", selectedMeals)
    }
    
    func getRecipeDetails(for mealID: String) {
        switch mealID {
        case "1":
            self.recipeName = "Scrambled Eggs"
            self.totalCalories = 250
        case "2":
            self.recipeName = "Oatmeal with Berries"
            self.totalCalories = 200
        case "3":
            self.recipeName = "Green Smoothie"
            self.totalCalories = 150
        case "4":
            self.recipeName = "Blueberry Pancakes"
            self.totalCalories = 350
        case "5":
            self.recipeName = "Avocado Toast"
            self.totalCalories = 180
        default:
            self.recipeName = "Unknown"
            self.totalCalories = 0
        }
        print("Recipe details for meal ID \(mealID): Name - \(recipeName), Calories - \(totalCalories)")
    }
}



struct TempBreakfastSelect: View {
   
    @ObservedObject var viewModel = MockMealSelectionViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("white").edgesIgnoringSafeArea(.all)
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
                            ForEach(viewModel.mealOptions.keys.sorted(),id: \.self){ meal in
                                ExpandableView(thumbnail: ThumbnailView {
                                    
                                    VStack() {
                                        Text(meal)
                                            .frame(width: 200, height: 50)
                                              .foregroundColor(Color("Chocolate"))
                                              .font(.custom("ArialRoundedMTBold", size: 20))
                                              .background(
                                                  RoundedRectangle(cornerRadius: 10)
                                                      .fill(Color.white)
                                              )
                                              .padding(.horizontal, 30)
                                              .padding(.top,30)
                                        Image(viewModel.mealOptions[meal]!)
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
                                        Image(viewModel.mealOptions[meal]!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: .infinity, maxHeight: 100)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(viewModel.selectedMeals.contains(meal) ? Color.clear : Color.clear, lineWidth: 2)
                                                
                                            )
                                        Text(meal)
                                            .frame(maxWidth: .infinity,maxHeight: 50, alignment: .center)
                                              .foregroundColor(Color("Chocolate"))
                                              .font(.custom("ArialRoundedMTBold", size: 20))
                                              
                                              .background(
                                                  RoundedRectangle(cornerRadius: 10)
                                                      .fill(Color.white)
                                              )
                                              .padding(.horizontal)
                                        
                                        Text("Recipe: \(viewModel.recipeName)")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18))
                                            .padding(.horizontal)
                                        
                                        Text("Calories: \(viewModel.totalCalories)")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18))
                                            .padding(.horizontal)
                                        Spacer()
                                    }
                                    .padding()
                                    .onAppear {
                                        viewModel.getRecipeDetails(for: viewModel.mealOptions[meal]!)
                                        }
                                }, thumbnailViewBackgroundColor: Color("GreyTone").opacity(0.7), expandedViewBackgroundColor: Color("BabyBlue")
                                )
                                .padding(.leading,10)
                                
                                Button(action: {
                                    viewModel.toggleMealSelection(meal)// Toggle the selection state when tapped
                                    
                                }){
                                    Image(systemName:"plus.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .foregroundStyle(viewModel.selectedMeals.contains(meal) ? Color.teal : Color.gray)
                    
           
                                }
                                .padding(.top,300)
                                .padding(.leading,-90)
                                
                                
                                
                        }
                            .padding(.horizontal ,7)
                        
                  
                            
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
               
                
            }
        }
        .navigationBarBackButtonHidden()
        
        
    }
}




struct TempBreakfastSelect_Previews: PreviewProvider {
    static var previews: some View {
    
        TempBreakfastSelect()
    }
}

