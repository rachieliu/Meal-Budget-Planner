//
//  BudgetSelectView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

class BudgetSelectViewModel: ObservableObject {
    @Published var selectedBudget: Int?
}

struct BudgetSelectView: View {
    @StateObject var viewModel = BudgetSelectViewModel()
    
    //variables are so user can only select one
    @State private var selected75 = false
    @State private var selected100 = false
    @State private var selected125 = false
    @State private var selected150 = false
    @State private var isNextViewActive = false
    
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    Image("Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width:150, height: 100)
                        .padding(.top, -115)
                    
                    
                    Text("Welcome User!")
                        .foregroundColor(Color("PrimaryColor"))
                        .fontWeight(.bold)
                        .font(.system(size:20))
                        .padding(.bottom, 20)
                    
                    VStack(spacing: 15){
                        Text("Select your")
                        
                        Text("WEEKLY GROCERY BUDGET")
                            .foregroundColor(Color("PrimaryColor"))
                            .fontWeight(.bold)
                            .font(.system(size:25))
                    
                        
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 24){
                        
                        
                        HStack{
                            SelectBudgetButton(isSelected: $selected75, color: Color( "PrimaryColor"), text: "$75")
                                .onTapGesture{
                                    selected75.toggle()
                                    
                                    if selected75{
                                        selected100 = false
                                        selected125 = false
                                        selected150 = false
                                    }
                                }
                            SelectBudgetButton(isSelected: $selected100, color: Color( "PrimaryColor"), text: "$100")
                                .onTapGesture{
                                    selected100.toggle()
                                    
                                    if selected100{
                                        selected75 = false
                                        selected125 = false
                                        selected150 = false
                                    }
                                }
                            
                            
                        }
                        HStack{
                            SelectBudgetButton(isSelected: $selected125, color: Color( "PrimaryColor"), text: "$125")
                                .onTapGesture{
                                    selected125.toggle()
                                    
                                    if selected125{
                                        selected75 = false
                                        selected100 = false
                                        selected150 = false
                                    }
                                }
                            SelectBudgetButton(isSelected: $selected150, color: Color( "PrimaryColor"), text: "$150")
                                .onTapGesture{
                                    selected150.toggle()
                                    
                                    if selected150{
                                        selected75 = false
                                        selected100 = false
                                        selected125 = false
                                    }
                                }
                        }
                        
                    }
                    .padding(.vertical, 20)
                   
                    
                    Button(action: {
                         // Trigger navigation only if a budget option is selected
                         if selected75 || selected100 || selected125 || selected150 {
                             isNextViewActive = true
                         }
                     }) {
                         HStack{
                             Text("LET'S GO")
                                 .fontWeight(.semibold)
                             Image(systemName: "arrow.right")
                         }
                         .foregroundColor(.white)
                         .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                         .background(Color("PrimaryColor"))
                         .cornerRadius(10)
                         .padding(.top, 20 )
                         .opacity((selected75 || selected100 || selected125 || selected150) ? 1.0 : 0.6)
                     }
                     .disabled(!(selected75 || selected100 || selected125 || selected150)) // Disable the button if no budget option is selected
                     
                     // Navigate to the next view when isNextViewActive becomes true
                     NavigationLink(
                         destination: BreakfastSelectView(),
                         isActive: $isNextViewActive,
                         label: { EmptyView() }
                     )
              
                    
                   
                    
                   
                   /** .onTapGesture {
                                        // Optionally, perform any logic related to the "LET'S GO" button tap
                                        // For example, you might want to save the selected budget in the viewModel
                                        // viewModel.selectedBudget = selectedBudgetValue
                                    }
                    */
                  
                   
                }
            }
            
        }
    }
}

struct BudgetSelectView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetSelectView()
    }
}
