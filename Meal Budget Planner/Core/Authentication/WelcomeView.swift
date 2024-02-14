//
//  WelcomeView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        
        //NavigationView so that buttons lead to next page
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    VStack {
                        Text("WELCOME TO THE")
                        Text("Meal Budget Planner")
                            .foregroundColor(Color("PrimaryColor"))
                    }
                    Image("Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width:100, height: 120)
                        .padding(.vertical,32)
                    
                   
                    
                    
                    Spacer()
                    
                    //coorelated with navigation view, navigation link defines the buttons to go to next page
                    
                    NavigationLink(
                        
                        //destination = what page your going to, hide navigation bar to hide the back arrow
                        
                        destination: SignupView(),
                        label: {
                            PrimaryButton(title: "Get Started")
                                
                        })
                    
                    NavigationLink(
                        destination: LoginView(),
                        label: {
                            Text("Sign In")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(50.0)
                                //.shadow(color:   Color.black.opacity(0.4), radius: 60, x: 0.0, y: 16)
                                .padding(.bottom, 50)
                                
                        })
                    .navigationBarHidden(true)
                    
            
                        
                    }
                
                
            }
            
            .padding()
            
        }
        
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeView()
                .previewInterfaceOrientation(.portrait)
            /*WelcomeView()
                .previewInterfaceOrientation(.landscapeLeft)
            WelcomeView()
                .previewInterfaceOrientation(.landscapeLeft)*/
        }
    }
}
