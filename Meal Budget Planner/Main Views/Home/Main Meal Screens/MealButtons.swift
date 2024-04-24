//
//  MealButtons.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/18/24.
//
/*

import SwiftUI

struct MealButtons: View {
 
    let title: String
    let mealID: String // Added parameter for selected meal
    
    
 
    var body: some View {
        NavigationLink(destination: FirstBudgetBreakfast(mealID: mealID, mealName: title )) {
           
            
            HStack {
                Image(mealID)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    
                
                Text(title)
                 
                    .font(.system(size: 20))
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    .foregroundColor(.black)
                   
                
                Spacer()
                
                Text("...")
                    //.fontWeight(.bold)
                    .font(.system(size: 30))
                    .foregroundColor(Color.black)
                    .padding(.trailing, 15)
                    .padding(.bottom)
                    .frame(width: 100, height: 100)
                    
            }
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous) // Apply rounded corners to the entire HStack
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0, style: .continuous) // Apply square corners to the left side
                            .fill(Color.clear)
                            .frame(width: 30, height: 120)
                            .offset(x: -15) // Offset to cover only the left side
                    )
                    .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
            )
            
        }
      //  .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
           // .background(Color.white)
            
        
        
    }
}
struct MealButtons_Previews: PreviewProvider {
    static var previews: some View {
        MealButtons(title: "American Breakfast", mealID: "1")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
*/
