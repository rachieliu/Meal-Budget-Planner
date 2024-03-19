//
//  SignupView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.
//

import SwiftUI

struct SignupView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
   // @State private var isEmailValid: Bool = true // Track email validation state
    //@State private var validationError: String? // Validation error message
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack{
                
                
                Image("Icon")
                    .resizable()
                    .scaledToFill()
                    .frame(width:150, height: 100)
                    .padding(.vertical, 32)
                
                VStack(spacing: 24 ){
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                    .autocapitalization(.none)
                    
                    InputView(text: $fullname,
                              title: "Name",
                              placeholder: "Enter your name",
                              isSecureField: true)
                    
                    //password strengthening alerts
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                    
                    //implement error checking
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Re-enter your password")
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                NavigationLink(
                    destination:
                        BudgetSelectView()
                        .navigationBarHidden(true),
                    label:{
                        HStack{
                            Text("CREATE ACCOUNT")
                                .fontWeight(.semibold)

                            Image(systemName: "arrow.right")
                        
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    .background(Color("PrimaryColor"))
                    .cornerRadius(10)
                    .padding(.top, 30)
                   
                    
                })
               /* .onTapGesture{
                    //create account when button is pressed
                    createAccount()
                }
                
                
                if let error = validationError{
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.top, 8)
                }*/
                Spacer()
                
                NavigationLink(
                    destination: LoginView().navigationBarHidden(true),
                    label: {
                        HStack(spacing: 3){
                            Text("Already have an account?")
                            Text("Sign In")
                                .fontWeight(.bold)
                        }
                        .font(.system(size:14))
                        .foregroundColor(Color(.systemBlue))
                            
                })
            }
        }
    }
   
  /*  func isValidEmail(email: String) -> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
    func createAccount() {
            if !isValidEmail(email: email) {
                // If email is invalid, set validation error
                validationError = "Invalid email"
            } else {
                // If email is valid, reset validation error
                validationError = nil
                
                // Perform further actions for account creation
                // This could include password validation, submitting data to server, etc.
            }
        }*/
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           
            SignupView()
        }
    }
}
