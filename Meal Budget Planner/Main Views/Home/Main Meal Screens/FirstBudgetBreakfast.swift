//
//  FirstBudgetBreakfast.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//
import Firebase
import SwiftUI

struct FirstBudgetBreakfast: View {
    let mealID: String // meal id for image
    let mealName:String //parameter for meal name
    
    @State private var ingredients: [String] = []
    @State private var recipe: [String] = []
    
    init(mealID: String, mealName: String) {
        self.mealID = mealID
        self.mealName = mealName
    }
    var body: some View {
        ScrollView {
            VStack {
                VStack{
                    Image("\(mealID)")
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .frame(maxWidth: .infinity, maxHeight: 100)
                        .overlay(
                            Capsule()
                                .foregroundColor(Color("white").opacity(0.8))
                                .frame(maxWidth: 300)
                                .frame(height: 100)
                                .overlay(
                                    Text(mealName)
                                        .font(.title)
                                        .foregroundColor(Color("Black"))
                                        .fontWeight(.semibold)
                                    
                                    
                                )
                               // .shadow(color: Color.black.opacity(0.8), radius: 10, x: 0, y: 5)
                                .padding(.top, 250) 
                                .alignmentGuide(.bottom) { d in d[.bottom] }
                           
                        )
                    
                }
                
                
               
                VStack(alignment: .leading, spacing: 10) {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("Barf"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                   
                        .overlay(
                            Text("Ingredients:")
                            
                                .fontWeight(.bold)
                                .font(.title3)
                                .padding(.trailing, 200)
                                .padding(.bottom,3)// Add padding to the text
                                .foregroundColor(Color("Black"))
                        )
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], alignment: .leading, spacing: 16) {
                        ForEach(ingredients, id: \.self) { ingredient in
                            Text("\(ingredient)")
                                .padding(.horizontal,10)
                        }
                       // .frame(maxWidth:.infinity, maxHeight: 200)
                        
                    }
                    /*
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1) // Adjust color and width as needed
                            
                        )*/
                    
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("GreyTone"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 50)
                        //.padding(.top, 0)
                        .overlay(
                            Text("Recipe:")
                            
                                .fontWeight(.bold)
                                .font(.title3)
                                .padding(.trailing, 250)
                                .padding(.bottom,3)// Add padding to the text
                                .foregroundColor(Color("Black"))
                        )
                    ForEach(recipe, id: \.self) { step in
                        Text("- \(step)")
                            .multilineTextAlignment(.center)
                    }
                }
                .background(Color("white"))
                
                .padding(.top, 150)
                .cornerRadius(10)
                .padding()
                
            
            }
            //.edgesIgnoringSafeArea(.top) // Ignore safe area to fill the entire screen
            .onAppear {
                fetchMealDetails()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color("white"))
    }
    private func fetchMealDetails() {
        // Assuming you have a database reference set up
        let ref = Database.database().reference().child("MEALS").child(mealID)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let mealData = snapshot.value as? [String: Any] else {
                print("Failed to fetch meal data")
                return
            }
            
            // Fetch ingredients and recipe from the database
            if let ingredientsString = mealData["Ingredients"] as? String {
                ingredients = ingredientsString.components(separatedBy: ",")
            }
            if let recipeString = mealData["Recipe"] as? String {
                recipe = recipeString.components(separatedBy: ",")
            }
        }
    }
}

struct FirstBudgetBreakfast_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample meal ID and meal name for preview
        let mealID = "1"
        let mealName = "American Breakfast"
        
        // Pass the meal ID and meal name to the FirstBudgetBreakfast view
        FirstBudgetBreakfast(mealID: mealID, mealName: mealName)
    }
}
