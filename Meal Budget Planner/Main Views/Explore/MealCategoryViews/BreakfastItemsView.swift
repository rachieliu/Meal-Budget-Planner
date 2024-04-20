//
//  MealItemsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/20/24.
//

import SwiftUI



struct BreakfastItemsView: View {
    let breakfastImageNames = ["1b1", "1b2", "1b3", "1b4", "1b5", "2b1", "2b2", "2b3", "2b4", "2b5"]
    let breakfastImagesNames2 = ["3b1", "3b2", "3b3", "3b4", "3b5", "4b1", "4b2", "4b3", "4b4", "4b5"] // Changed image names
    
    @State private var isMealExpanded = Array(repeating: false, count: 20)
    private var homeGridItems: [GridItem] = [
        .init(.flexible())
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Display meal images
                    HStack(alignment: .top) {
                        
                        // First set of meal images
                        
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<breakfastImageNames.count, id: \.self) { index in
                                MealItemView(imageName: breakfastImageNames[index], isExpanded: $isMealExpanded[index])
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        // Second set of meal images
                        LazyVGrid(columns: homeGridItems) {
                            ForEach(0..<breakfastImagesNames2.count, id: \.self) { index in
                                MealItemView(imageName: breakfastImagesNames2[index], isExpanded: $isMealExpanded[index + breakfastImageNames.count])
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("Breakfast")
        }
    }
    /*
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
                                        .frame(width: 180, height: CGFloat.random(in: 180...250), alignment: .center)
                                }
                                
                            }
                            
                            
                        }
                        .frame(maxWidth: .infinity)
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
                        .frame(maxWidth: .infinity)
                        
                        
                        
                        
                        
                    }
                    Spacer()
                    
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
        
    }*/
}
struct MealItemView: View {
    let imageName: String
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack {
            // Meal image
            Image(imageName)
                .resizable()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(width: 180, height: isExpanded ? 250 : CGFloat.random(in: 180...250), alignment: .center)
                .overlay(
                    Button(action: {
                        isExpanded.toggle()
                    }) {
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .padding(8)
                    }
                    .offset(x: 60, y: 0), // Adjust the offset for proper positioning
                    alignment: .top // Align the overlay to the top of the image
                )
            if isExpanded {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Meal Details")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Text("Description goes here...")
                            .font(.subheadline)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
                           // Expandable icon
 /*           Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                .foregroundColor(.blue)
                .padding(.top, 5)
            
            // Meal details (displayed when expanded)
            if isExpanded {
                Text("Meal details go here...")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }*/
        }
    }
}


struct BreakfastItemsView_Previews: PreviewProvider {
    
    
    
    
    static var previews: some View {
        BreakfastItemsView()
    }
}

