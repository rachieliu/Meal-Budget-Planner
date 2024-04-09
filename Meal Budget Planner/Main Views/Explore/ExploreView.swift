//
//  ExploreView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/13/24.
//
import SwiftUI

struct Box: Identifiable {
    let id: Int
    let title: String
    let image: String
}

struct ExploreView: View {
    //@State private var selectedTab: Int = 0 // Define selectedTab here
    @State private var selectedBoxId: Int? = nil
    
    let boxes: [Box] = [
        Box(id: 0, title: "Breakfast", image: "bfastbagel"),
        Box(id: 1, title: "Lunch", image: "bfastburrito"),
        Box(id: 2, title: "Dinner", image: "proteinsmoothie")
    ]
    
    var body: some View {
        TabView {
            ForEach(boxes.indices) { index in
                NavigationView {
                    VStack(spacing: 0) {
                        ScrollView {
                            HStack(spacing: 20) {
                                ForEach(boxes) { box in
                                    Button(action: {
                                        // Select the corresponding tab
                                        self.selectedBoxId = box.id
                                    }) {
                                        BoxView(box: box)
                                    }
                                    .foregroundColor(self.selectedBoxId == box.id ? .orange : .black)
                                }
                            }
                            .padding()
                        }
                        
                    
                        VStack{
                        // Display content based on the selected tab
                            if selectedBoxId != nil {
                                switch index {
                                case 0:
                                    if let selectedBoxId = selectedBoxId, selectedBoxId == 0 {
                                        BreakfastItemsView()
                                    }
                                    else{
                                        EmptyView()
                                    }
                                case 1:
                                    if let selectedBoxId = selectedBoxId, selectedBoxId == 1 {
                                        LunchItemsView()
                                    }
                                    else{
                                        EmptyView()
                                    }
                                case 2:
                                    if let selectedBoxId = selectedBoxId, selectedBoxId == 2 {
                                        DinnerItemsView()
                                    }
                                    else{
                                        EmptyView()
                                    }
                                default:
                                    EmptyView()
                                }
                            }
                        }
                        .padding(.top,-100)
                            
                        
                        Spacer()
                    }
                    .navigationBarTitle(Text("Explore"))
                }
                .tag(index)
            }
        }
       // .tabViewStyle(PageTabViewStyle())
    }
}

struct BreakfastView: View {
    var body: some View {
        Text("Breakfast Detail View")
    }
}

struct LunchView: View {
    var body: some View {
        Text("Lunch Detail View")
    }
}

struct DinnerView: View {
    var body: some View {
        Text("Dinner Detail View")
    }
}

struct BoxView: View {
    let box: Box
    
    var body: some View {
        VStack {
            Image(box.image)
                .resizable()
                .cornerRadius(12)
                .frame(width: 80, height: 80)
            Text(box.title)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
