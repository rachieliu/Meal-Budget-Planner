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
        GeometryReader { geometry in
            ZStack{
                Rectangle()
                    .frame(width: geometry.size.width, height: 50)
                    .foregroundColor(Color.clear)
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color("BabyPink").opacity(0.05), Color("white")]), startPoint: .trailing, endPoint: .leading)
                            .mask(Rectangle().frame(width: geometry.size.width, height: 50))
                    )
                Text(category)
                    .fontWeight(.ultraLight)
                    .font(
                        .custom("SF Pro Display", size: 13))
                    .foregroundColor(Color("DarkGrey"))
                    //.padding(.top, 30)
                    .padding(.trailing,50)
                   // .padding()
                    //.shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 3)
                    
            }
        }
            
    }
        
}
struct MealButtons: View {
    
    let title: String
    let mealID: String
    
    
    
    var body: some View {
        NavigationLink(destination: FirstBudgetBreakfast(mealID: mealID, mealName: title )) {
            
            ZStack {
                // Rounded rectangle for the text
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1), Color("BabyPink").opacity(0.7)]), startPoint: .trailing, endPoint: .leading))
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 3)
                    .frame(maxWidth: 320, maxHeight: 100)
                
                // Text
                HStack {
                    Spacer()
                    Text(title)
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                        .padding(.leading, 50)
                        .foregroundColor(Color("Black"))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 15))
                        .foregroundColor(Color("Black"))
                        .padding(.bottom)
                        .frame(width: 30, height: 30)
                }
                
                // Image
                Image(mealID)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.white, lineWidth: 5))
                    .offset(x: -150, y: -30)
                
            }
            .frame(maxWidth: 350, maxHeight: 120)
            .padding(.leading, 50)
        }
    }
}
  
struct MealButtons_Previews: PreviewProvider {
    static var previews: some View {
        MealButtons(title: "American Breakfast", mealID: "1")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

