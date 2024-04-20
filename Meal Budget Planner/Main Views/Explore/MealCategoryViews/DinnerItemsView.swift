//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI

struct DinnerItemsView: View {
    
    let dinnerImageNames = ["1d1", "1d2", "1d3", "1d4", "1d5", "2d1", "2d2", "2d3", "2d4", "2d5"]
    let dinnerImageNames2 = ["3d1", "3d2", "3d3", "3d4", "3d5", "4d1", "4d2", "4d3", "4d4", "4d5"]
    
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack{
                   
                    HStack(alignment: .top) {
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(dinnerImageNames, id: \.self){ imageName in
                                if let image = UIImage(named:imageName){
                                    Image(uiImage: image)
                                        .resizable()
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .frame(width: 180, height: CGFloat.random(in: 180...250), alignment: .center)
                                }
                                
                            }
                        }
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(dinnerImageNames2, id: \.self){ imageName in
                                if let image = UIImage(named:imageName){
                                    Image(uiImage: image)
                                        .resizable()
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .frame(width: 180, height: CGFloat.random(in: 180...250), alignment: .center)
                                }
                                
                            }
                        }
                    }
                   
                    
                }
                
            }
            .navigationBarHidden(true)
           
        }
        
        
    }
}
/*
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
    
}*/

struct DinnerItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        DinnerItemsView()
    }
}

