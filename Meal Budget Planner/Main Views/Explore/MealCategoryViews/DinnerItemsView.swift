//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI

struct DinnerItemsView: View {
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack{
                    Text("DINNER")
                    HStack(alignment: .top) {
                        LazyVGrid(columns: homeGridItems) {
                            dinnerimageList
                        }
                        LazyVGrid(columns: homeGridItems) {
                            dinnerimageList
                        }
                    }
                   
                    
                }
                
            }
            .navigationBarHidden(true)
           
        }
        
        
    }
}
extension DinnerItemsView{
    
    
    private var dinnerimageList: some View {
        ForEach(0...2, id: \.self) { _ in
            Image("proteinsmoothie")
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
        }
    }
    
}

struct DinnerItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        DinnerItemsView()
    }
}

