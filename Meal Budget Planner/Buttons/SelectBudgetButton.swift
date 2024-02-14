//
//  SelectBudgetButton.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

struct SelectBudgetButton: View {
    @Binding var isSelected: Bool
    @State var color: Color
    @State var text: String
    
    var body: some View {
        ZStack{
            Capsule()
                .frame(height:100)
                .foregroundColor(isSelected ? color : .gray)
            Text(text)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}

struct SelectBudgetButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectBudgetButton(isSelected: .constant(false), color: .blue, text: "Option")
    }
}
