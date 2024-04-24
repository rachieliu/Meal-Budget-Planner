//
//  LoginView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI
import Firebase
import FirebaseCore

// Function to check if an email is in a valid format
func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
    return emailPredicate.evaluate(with: email)
}

// Function to check if a password meets the criteria for a strong password
func isValidPassword(_ password: String) -> Bool {
    let passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[~!@#$%^&*()_+=\\-{}|\\[\\]:;\"<>,.?\\/]).{8,}$"
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
    return passwordPredicate.evaluate(with: password)
}

// Login view
struct LoginView: View {
    
    // State variables for email, password, view model, authentication status, and error message
    @ObservedObject var viewModel = LoginViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var errorMessage = ""
  
    //check if sign-in button should be disabled
    var isSignInDisabled: Bool {
        return email.isEmpty || password.isEmpty
    }
    
    
    var body: some View {
        NavigationView {
            
           
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack{
                    
                    //Icon Image
                    Image("Icon")
                        .resizable()
                        .scaledToFill()
                        .frame(width:150, height: 100)
                        .padding(.vertical, 32)
                    
                    //InputView for email and password entry
                    VStack(spacing: 24 ){
                        InputView(text: $email,
                                  title: "Email Address",
                                  placeholder: "name@example.com")
                        .autocapitalization(.none)
                        .foregroundColor(.black)
                        
                        
                        InputView(text: $password,
                                  title: "Password",
                                  placeholder: "Enter your password",
                                  isSecureField: true)
                        .foregroundColor(.black)
                        
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    // Sign-in button, checks if email and password valid in LoginViewModel
                    Button(action: {
                        if isValidEmail(email) && isValidPassword(password) {
                            viewModel.loginUser(email: email, password: password)
                        } else {
                            errorMessage = "Invalid email or password. Try again"
                            password = ""
                        }
                    }) {
                        HStack{
                            Text("SIGN IN")
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                    }
                    .opacity(isSignInDisabled ? 0.5 : 1.0)
                    .disabled(isSignInDisabled)
                    
                    // Navigation link to hidden TabBarView when user is authenticated
                    NavigationLink(destination: TabBarView(),
                                   isActive: Binding<Bool>(
                                    get:{ viewModel.isAuthenticated},
                                    set:{ _ in}),
                                   label: {EmptyView()}
                    ).hidden()
                
                    .padding(.top, 24)
                    Text(errorMessage)
                                      .foregroundColor(.red)
                                      .font(.system(size: 14))
                                      .padding(.top, 8)
                    
                    NavigationLink(
                        destination: WelcomeView().navigationBarHidden(true),
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
