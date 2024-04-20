//
//  AllMealsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/13/24.
//

import SwiftUI

struct AllMealsView: View {
    let allBreakfastImage = ["1b1", "1b2", "1b3", "1b4", "1b5", "2b1", "2b2", "2b3", "2b4", "2b5"]
    let allBreakfastImage2 = ["3b1", "3b2", "3b3", "3b4", "3b5", "4b1", "4b2", "4b3", "4b4", "4b5"]
    
    let allLunchImage = ["1l1", "1l2", "1l3", "1l4", "1l5", "2l1", "2l2", "2l3", "2l4", "2l5"]
    let allLunchImage2 = ["3l1", "3l2", "3l3", "3l4", "3l5", "4l1", "4l2", "4l3", "4l4", "4l5"]
    
    let allDinnerImage = ["1d1", "1d2", "1d3", "1d4", "1d5", "2d1", "2d2", "2d3", "2d4", "2d5"]
    let allDinnerImage2 = ["3d1", "3d2", "3d3", "3d4", "3d5", "4d1", "4d2", "4d3", "4d4", "4d5"]
    
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    
    var body: some View {
        
        NavigationView{
            ScrollView {
                
                VStack{
                    //CategoryTitle(title: "All Meals")
                    
                    Text("Breakfast")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        .padding(.vertical, 20)
                        .padding(.leading)
                        
                        
                    
                    HStack(alignment: .top){
                        LazyVGrid(columns: homeGridItems){
                            ForEach(allBreakfastImage, id: \.self){ imageName in
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
                            ForEach(allBreakfastImage2, id: \.self){ imageName in
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
                    Text("Lunch")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        .padding(.vertical, 20)
                        .padding(.leading)
                   // CategoryTitle(title: "Lunch")
                    HStack(alignment: .top){
                        LazyVGrid(columns: homeGridItems){
                            ForEach(allLunchImage, id: \.self){ imageName in
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
                            ForEach(allLunchImage2, id: \.self){ imageName in
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
                    Spacer()
                    Text("Dinner")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        .padding(.vertical, 20)
                        .padding(.leading)
                    
                    HStack(alignment: .top){
                        LazyVGrid(columns: homeGridItems){
                            ForEach(allDinnerImage, id: \.self){ imageName in
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
                            ForEach(allDinnerImage2, id: \.self){ imageName in
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

struct CategoryTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 20) // Add some top padding to separate categories
    }
}

#Preview {
    AllMealsView()
}
