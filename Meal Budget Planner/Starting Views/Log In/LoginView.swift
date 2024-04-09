//
//  LoginView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
  
    
    var isSignInDisabled: Bool {
        return email.isEmpty || password.isEmpty
    }
    
    
    var body: some View {
        NavigationView {
            
            //ZStack is for incase we want background color
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    
                    //Icon Image
                    Image("Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width:150, height: 100)
                        .padding(.vertical, 32)
                    
                    //InputView is defined in the Components file, acts as a template for input forms
                    VStack(spacing: 24 ){
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        
                        //
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    
                    NavigationLink(
                        destination:
                            TabBarView()
                            .navigationBarHidden(true),
                        label:{
                            HStack{
                                Text("SIGN IN")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                        .opacity(isSignInDisabled ? 0.5 : 1.0)
                        .disabled(isSignInDisabled)
                        
                    })

                    .padding(.top, 24)
                    
                    NavigationLink(
                        destination: MyMealsView().navigationBarHidden(true),
                        label: {
                            HStack(spacing: 3){
                                Text("Forgot password?")
                                    .fontWeight(.semibold)
                                    
                            }
                            .foregroundColor(.gray)
                            .font(.system(size:14))
                                
                    })
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: CreateAccountView().navigationBarHidden(true),
                        label: {
                            HStack(spacing: 3){
                                Text("Don't have an account?")
                                Text("Sign Up")
                                    .fontWeight(.bold)
                            }
                            .font(.system(size:14))
                                
                    })
                        
                        
                    
                   
                    
                    
                    
                    
                }
                
            }
            .navigationBarHidden(true)
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
