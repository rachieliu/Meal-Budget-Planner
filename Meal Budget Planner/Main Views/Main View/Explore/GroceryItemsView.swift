//
//  GroceryItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//
import SwiftUI

struct GroceryItemsView: View {
    
    var groceryItemModels: [GroceryItemModel]
    
    let screenWidth = UIScreen.main.bounds.width/2 - 32
   
    var body: some View {
        
        GridStack(minCellWidth: screenWidth, spacing: 10, numItems: groceryItemModels.count, alignment: .center) { index, cellWidth in
        
            GroceryItemsRow(groceryItemModel: self.groceryItemModels[index])
        
        }
        .background(Rectangle().foregroundColor(.color("#fafafa")))
    }
    
}

struct GroceryItemsView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemsView(groceryItemModels: LocalDataHandler.productsData)
    }
}
