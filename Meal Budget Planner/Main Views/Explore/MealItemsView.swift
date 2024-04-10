//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI

struct MealItemsView: View {
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack{
                    Text("BREAKFAST")
                    HStack(alignment: .top) {
                        LazyVGrid(columns: homeGridItems) {
                            breakfastimageList
                        }
                        LazyVGrid(columns: homeGridItems) {
                            breakfastimageList
                        }
                    }
                    Text("LUNCH")
                    HStack(alignment: .top) {
                        LazyVGrid(columns: homeGridItems) {
                            lunchimageList
                        }
                        LazyVGrid(columns: homeGridItems) {
                            lunchimageList
                        }
                    }
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
extension MealItemsView{
    
    
    private var breakfastimageList: some View {
        ForEach(0...2, id: \.self) { _ in
            Image("proteinsmoothie")
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
        }
    }
    private var lunchimageList: some View {
        ForEach(0...2, id: \.self) { _ in
            Image("bfastbagel")
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
        }
    }
    private var dinnerimageList: some View {
        ForEach(0...2, id: \.self) { _ in
            Image("bfastburrito")
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
        }
    }
}

struct MealItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        MealItemsView()
    }
}


