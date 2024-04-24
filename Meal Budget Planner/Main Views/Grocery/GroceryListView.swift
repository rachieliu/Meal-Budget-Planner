//
//  GroceryListView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/13/24.
//

import SwiftUI

struct GroceryListView: View {
    @State private var produce = Food.Produce()
    @State private var dairy = Food.Dairy()
    @State private var meat = Food.Meat()
    @State private var grains = Food.Grains()
    @State private var other = Food.Other()
    
    //@State private var tabSelection = 0
    var body: some View {
        ZStack{
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                Text("Grocery List")
                    .font(.system(size: 30, weight: .bold)) // Adjust font size and weight as needed
                    .foregroundColor(.black) // Adjust color to match the navigation title style
                    .padding(.top, 30) // Add top padding
                
                
                
                Image("background1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all) // Ignore safe area edges if needed
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        List {
                            Section {
                                ForEach(produce) { food in
                                    GroceryRow(food: food)
                                    
                                }.listRowBackground(
                                    Capsule()
                                        .fill(Color(white: 1, opacity: 0.8))
                                        .padding(.vertical, 2).padding(.horizontal, 20)
                                )
                            } header: {
                                Text("Produce")
                            }
                            
                            
                            Section {
                                ForEach(dairy) { food in
                                    GroceryRow(food: food)
                                }.listRowBackground(
                                    Capsule()
                                        .fill(Color(white: 1, opacity: 0.8))
                                        .padding(.vertical, 2).padding(.horizontal, 20)
                                )
                            } header: {
                                Text("Eggs & Dairy")
                            }
                            .listRowSeparatorTint(.green, edges: .all)
                            
                            Section {
                                ForEach(meat) { food in
                                    GroceryRow(food: food)
                                }.listRowBackground(
                                    Capsule()
                                        .fill(Color(white: 1, opacity: 0.8))
                                        .padding(.vertical, 2).padding(.horizontal, 20)
                                )
                                
                            } header: {
                                Text("Meat")
                            }
                            .listSectionSeparatorTint(.red)
                            
                            Section {
                                ForEach(grains) { food in
                                    GroceryRow(food: food)
                                }
                                .listRowBackground(
                                    Capsule()
                                        .fill(Color(white: 1, opacity: 0.8))
                                        .padding(.vertical, 2).padding(.horizontal, 20)
                                )
                            } header: {
                                Text("Grains")
                            }
                            .listRowSeparatorTint(.green, edges: .all)
                            Section {
                                ForEach(other) { food in
                                    GroceryRow(food: food)
                                }.listRowBackground(
                                    Capsule()
                                        .fill(Color(white: 1, opacity: 0.8))
                                        .padding(.vertical, 2).padding(.horizontal, 20)
                                )
                            } header: {
                                Text("Other")
                            }
                            
                            
                        }
                        .background(
                            Color.clear)
                        
                    )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
           
    }
}
