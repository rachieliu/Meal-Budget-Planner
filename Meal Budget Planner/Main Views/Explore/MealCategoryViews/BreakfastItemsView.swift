//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI



struct BreakfastItemsView: View {
    let breakfastImageNames = ["0", "1", "2", "3", "4"]
    let breakfastImagesNames2 = ["5", "6", "7", "8", "9"] // Changed image names
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView{
            ScrollView {
                VStack{
                    HStack(alignment: .top){
                        LazyVGrid(columns: homeGridItems){
                            ForEach(breakfastImageNames, id: \.self){ imageName in
                                if let image = UIImage(named:imageName){
                                    Image(uiImage: image)
                                        .resizable()
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
                                }
                                
                            }
                            
                            
                        }
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(breakfastImagesNames2, id: \.self){ imageName in
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
                       /* LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) { // You can adjust the minimum width as needed
                            ForEach(breakfastImageNames, id: \.self) { imageName in
                                if let image = UIImage(named: imageName) { // Assuming images are in Assets catalog
                                    Image(uiImage: image)
                                        .resizable()
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        //.aspectRatio(contentMode: .fill)
                                        .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
                                        .cornerRadius(10)
                                        .padding(4)
                                }
                            }
                        }*/
            }
        }
        //.padding()
        
    }
}
/*
extension BreakfastItemsView{
    
    
    private var breakfastimageList: some View {
        ForEach(0...2, id: \.self) { _ in
            Image("proteinsmoothie")
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 180, height: CGFloat.random(in: 180...300), alignment: .center)
            
        }
    }
    
}*/

struct BreakfastItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        BreakfastItemsView()
    }
}

