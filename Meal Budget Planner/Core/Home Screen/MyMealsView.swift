//
//  MyMealsView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

struct MyMealsView: View {
    
   // @State var tabSelection = 3

   /* let tabBarItems: [(image: String, title: String)] = [
        
        ("GroceryIcon", "Grocery"),
        ("ExploreIcon", "Explore"),
        ("HomeIcon", "My Meals"),
        ("BudgetIcon", "My Budget")

    ]*/
    
    var body: some View {
        
        
        NavigationView{
            
/****------------------icon and ACCOUNT PROFILE BUTTON------------------- **/
            
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                Image("Icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width:150, height: 100)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 750, trailing: 0))
                
                
                NavigationLink(
                    destination:
                        MyAccountView(),
                    label:{

                        Image(systemName: "heart.fill")
                        
                    
                    .foregroundColor(.black)
                    .frame(width: 50, height: 50)
                    
                    
                })
                .background(Color("PrimaryColor"))
                .cornerRadius(50)
                .padding(EdgeInsets(top: 0, leading: 300, bottom: 750, trailing: 20))
                //Color("Color").edgesIgnoringSafeArea(.all)
                
               
    /****------------------PAGE NAME (MY MEAL PLAN------------------- **/
                
                VStack{
                    Text("My Meal Plan")
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: -60, leading: 0, bottom: 0, trailing: 0))
                    
                    
    /****------------------SCROLLING CALENDAR------------------- **/
                   
                    HStack{
                        
                        NavigationLink(
                            destination:
                                LunchSelectView()
                                .navigationBarHidden(true),
                            label:{

                                Image(systemName: "arrow.left")
                                
                            
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color("color"))
                        .cornerRadius(10)
                        
                        
                        
                        NavigationLink(
                            destination:
                                MyAccountView(),
                            label:{

                                Image(systemName: "heart.fill")
                                
                            
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color("PrimaryColor"))
                        .cornerRadius(50)
                        NavigationLink(
                            destination:
                                MyAccountView(),
                            label:{

                                Image(systemName: "heart.fill")
                                
                            
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color.gray)
                        .cornerRadius(50)
                        NavigationLink(
                            destination:
                                MyAccountView(),
                            label:{

                                Image(systemName: "heart.fill")
                                
                            
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color.gray)
                        .cornerRadius(50)
                        NavigationLink(
                            destination:
                                MyAccountView(),
                            label:{

                                Image(systemName: "heart.fill")
                                
                            
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color.gray)
                        .cornerRadius(50)
                        
                        
                        NavigationLink(
                            destination:
                                MyAccountView(),
                            label:{

                                Image(systemName: "heart.fill")
                                
                            
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color.gray)
                        .cornerRadius(50)
                        
                        
                        NavigationLink(
                            destination:
                                MyAccountView(),
                            label:{

                                Image(systemName: "heart.fill")
                                
                            
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color.gray)
                        .cornerRadius(50)
                        
                        NavigationLink(
                            destination:
                                MyAccountView(),
                            label:{

                                Image(systemName: "heart.fill")
                                
                            
                            .foregroundColor(.white)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color.gray)
                        .cornerRadius(50)
                       // .padding(EdgeInsets(top: 0, leading: 300, bottom: 750, trailing: 20))
                        
                        NavigationLink(
                            destination:
                                LunchSelectView()
                                .navigationBarHidden(true),
                            label:{

                                Image(systemName: "arrow.right")
                                
                            
                            .foregroundColor(.black)
                            .frame(width: 35, height: 35)
                            
                            
                        })
                        .background(Color("Color"))
                        .cornerRadius(10)
                        
                        
                    
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .background(Color("Color"))
                    .padding(EdgeInsets(top: -35, leading: 0, bottom: 10, trailing: 0))
                    
                    
                    
                    
  /****-----------------MEAL BUTTONS-------------------------------------------- **/
                    VStack{
                        VStack{
                            Text("B R E A K F A S T")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(EdgeInsets(top: 0, leading: -65, bottom: -200, trailing: 140))
                                
                            
                            NavigationLink(
                                destination:
                                    BudgetSelectView(),
                                label:{
                                    HStack{
                                        Text("Meal Name")
                                            .fontWeight(.semibold)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 50))
                                            

                                        Text("...")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .padding(EdgeInsets(top: 0, leading: 130, bottom: 15, trailing: 15))
                                    
                                }
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 80)
                                
                            })
                            .background(Color("PrimaryColor"))
                            .cornerRadius(20)
                            .padding(.top, 20)
                        }
                        
                        VStack{
                            Text("L U N C H")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(EdgeInsets(top: 20, leading: -65, bottom: -90, trailing: 200))
                            
                            NavigationLink(
                                destination:
                                    BudgetSelectView(),
                                label:{
                                    HStack{
                                        Text("Meal Name")
                                            .fontWeight(.semibold)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 50))
                                            

                                        Text("...")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .padding(EdgeInsets(top: 0, leading: 130, bottom: 15, trailing: 15))
                                    
                                }
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 80)
                                
                            })
                            .background(Color("PrimaryColor"))
                            .cornerRadius(20)
                            .padding(.top, 40)
                        }
                        
                        VStack{
                            Text("D I N N E R")
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .padding(EdgeInsets(top: 20, leading: -65, bottom: -90, trailing: 200))
                            
                            NavigationLink(
                                destination:
                                    BudgetSelectView(),
                                label:{
                                    HStack{
                                        Text("Meal Name")
                                            .fontWeight(.semibold)
                                            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 50))
                                            

                                        Text("...")
                                            .font(.system(size: 30))
                                            .fontWeight(.bold)
                                            .padding(EdgeInsets(top: 0, leading: 130, bottom: 15, trailing: 15))
                                    
                                }
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 80)
                                
                            })
                            .background(Color("PrimaryColor"))
                            .cornerRadius(20)
                            .padding(EdgeInsets(top: 40, leading: 0, bottom: 40, trailing: 0))
                        }
                    }
                    
                    .padding()
                    
                    /*-----------NAVIGATION BAR-------------------------------------------*/
                                        
                   CustomTabView(tabSelection: .constant(3))
                                           .frame(height:80)
                    
                    
/*-----------NAVIGATION BAR-------------------------------------------
                    
                    CustomTabView(tabSelection: $tabSelection, tabBarItems:[
                                ("GroceryIcon", "Grocery", GroceryListView()),
                                ("ExploreIcon", "Explore", ExploreView()),
                                ("HomeIcon", "My Meals", MyMealsView()), // Use MyMealsView for the "My Meals" tab
                                ("BudgetIcon", "My Budget", MyBudgetView())
                                ])*/
                    .padding(.bottom, -200)
                    
                    
                }
                
            }
        }
    }
}

struct MyMealsView_Previews: PreviewProvider {
    static var previews: some View {
        MyMealsView()
            
    }
}
