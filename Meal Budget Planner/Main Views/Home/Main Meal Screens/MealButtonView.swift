//
//  MealButtonView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/19/24.
//

import SwiftUI

struct MealButtonView: View {
    let category: String
    
    var body: some View {
        Text(category)
            //.fontWeight(.bold)
            .font(.system(size: 20))

            .padding(.leading,-140)
            .padding(.top)
    }
}



struct MealButtons: View {
    let title: String
    
    var body: some View {
        NavigationLink(destination: FirstBudgetBreakfast()) {
            HStack {
                Text(title)
                    //.fontWeight(.bold)
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 20)
                    //.background(Color("PrimaryColor"))
                   // .cornerRadius(20)
                
                Spacer()
                
                Text("...")
                    //.fontWeight(.bold)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
                    .padding(.trailing, 15)
                    .padding(.bottom)
            }
        }
        .background(Color("PrimaryColor"))
        .cornerRadius(20)
        
    }
}


