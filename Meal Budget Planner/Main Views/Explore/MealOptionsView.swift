//
//  MealOptionsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI

struct MealOptionsView: View {
    var mealItemModels: [MealItemModel]
        
        let screenWidth = UIScreen.main.bounds.width/2 - 32
       
        var body: some View {
            
            GridStack(minCellWidth: screenWidth, spacing: 10, numItems: mealItemModels.count, alignment: .center) { index, cellWidth in
            
                MealItemsRow(mealItemModel: self.mealItemModels[index])
            
            }
            .background(Rectangle().foregroundColor(Utils.getColor("#fafafa")))
        }
}

struct MealOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        MealOptionsView(mealItemModels: LocalDataHandler.productsData)
    }
}
