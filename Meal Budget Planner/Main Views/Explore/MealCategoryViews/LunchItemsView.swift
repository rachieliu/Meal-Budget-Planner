//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI

struct LunchItemsView: View {
    let lunchImagesNames = ["1l1", "1l2", "1l3", "1l4", "1l5", "2l1", "2l2", "2l3", "2l4", "2l5"]
    let lunchImagesNames2 = ["3l1", "3l2", "3l3", "3l4", "3l5", "4l1", "4l2", "4l3", "4l4", "4l5"]
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack{
                  
                    HStack(alignment: .top) {
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(lunchImagesNames, id: \.self){ imageName in
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
                            ForEach(lunchImagesNames2, id: \.self){ imageName in
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
            //.navigationBarHidden(true)
           
        }
        
        
    }
}
/*
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
    
}*/

struct LunchItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        LunchItemsView()
    }
}

