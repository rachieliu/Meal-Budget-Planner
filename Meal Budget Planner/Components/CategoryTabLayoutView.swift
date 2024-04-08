//
//  CategoryTabLayoutView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI

struct CategoryTabLayoutView: View {
    var categoryItemModel  : [CategoryItemModel]
       @ObservedObject var categoryObservable : CategorySelectedObservable
       var onTabChangeListener: TabChangeDelegate?
       
       var body: some View {
           ScrollView (.horizontal, showsIndicators: false) {
               HStack {
                   //contents
                   ForEach(categoryItemModel) { result in
                       TabLayoutRow(categoriesItemModel: result,
                                    selectedId: self.categoryObservable.selectedId,
                                    onTabChangeDelegate: self.onTabChangeListener)
                   }
               }.padding(.top)
           }
       }
}

struct CategoryTabLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTabLayoutView(categoryItemModel: LocalDataHandler.categoriesData,
                              categoryObservable: CategorySelectedObservable()).previewLayout(.fixed(width: 380, height: 60)
    }
}
