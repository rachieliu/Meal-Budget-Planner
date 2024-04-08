//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI

struct LunchItemsView: View {
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack{
                  
                    HStack(alignment: .top) {
                        LazyVGrid(columns: homeGridItems) {
                            lunchimageList
                        }
                        LazyVGrid(columns: homeGridItems) {
                            lunchimageList
                        }
                    }
                   
                    
                }
                
            }
            .navigationBarHidden(true)
           
        }
        
        
    }
}
extension LunchItemsView{
    
    
    private var lunchimageList: some View {
        ForEach(0...2, id: \.self) { _ in
            Image("bfastbagel")
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
        }
    }
    
}

struct LunchItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        LunchItemsView()
    }
}

