//
//  SignupView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI
import Firebase
import FirebaseCore


struct CreateAccountView: View {
    
    
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var navigateToBudgetSelect = false // Track navigation status

    
    var body: some View {
        NavigationView {
          
            VStack {
                Image("Icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width:150, height: 100)
                    .padding(.vertical, 32)
                VStack {
                    
                    // Entry field for user's name
                    EntryFieldView( title: "Name",
                                    placeholder: "Enter your name",
                                    prompt: viewModel.userNamePrompt,
                                    field: $viewModel.userName)
                    
                    // Entry field for user's email
                    EntryFieldView( title: "Email",
                                    placeholder: "name@example.com",
                                    prompt: viewModel.emailPrompt,
                                    field: $viewModel.email)
                    
                        .autocapitalization(.none)
                    
                   
                    // Entry field for password
                    EntryFieldView( title: "Password",
                                    placeholder: "Enter your password",
                                    prompt: viewModel.passwordPrompt,
                                    field: $viewModel.password,
                                    isSecure: true)
                    
                    
                    // Entry field for re-enter password
                    EntryFieldView(title: "Confirm Password",
                                   placeholder: "Re-enter your password",
                                   prompt: viewModel.confirmPwPrompt,
                                   field: $viewModel.confirmPw,
                                   isSecure: true)
                    
                    
                    
                    // Button to create account
                    Button(action: {
                        
                        // Check if all fields are valid
                        guard viewModel.isFieldValid(viewModel.userName),
                              viewModel.isFieldValid(viewModel.email),
                              viewModel.isFieldValid(viewModel.password),
                              viewModel.isFieldValid(viewModel.confirmPw) else {

                            //error for invalid symbols
                             viewModel.errorMessage = "Error: Invalid characters present in one or more fields"
                            return
                        }
                        viewModel.createAccount(navigateToBudgetSelect: $navigateToBudgetSelect)
                      
                    }) {
                        Text("CREATE ACCOUNT")
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 20)
                    .padding(.horizontal)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .opacity(viewModel.canSubmit ? 1 : 0.6)
                    .disabled(!viewModel.canSubmit)
                    
                    //dislpay error message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding(.bottom, 5)
                    }

                    
                    NavigationLink(
                        destination: BudgetSelectView().navigationBarHidden(true),
                        isActive: $navigateToBudgetSelect
                    ) {
                        EmptyView()
                    }
      
                    
                    .padding(.bottom, 5)
                    
                    
                    NavigationLink(
                        destination: LoginView().navigationBarHidden(true),
                        label: {
                            HStack(spacing: 3){
                                Text("Already have an account?")
                                Text("Sign In")
                                    .fontWeight(.bold)
                            }
                            .font(.system(size:12))
                            .foregroundColor(Color(.systemBlue))
                    
                        })
                    
                }
                .padding()
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 20)
                
                .padding(.bottom, 50)
                .navigationBarHidden(true)
              
            }
            
        
        }
        .onAppear {
            viewModel.navigateToBudgetSelect = false // Ensure navigateToBudgetSelect is reset when view appears
        }
        
        
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
