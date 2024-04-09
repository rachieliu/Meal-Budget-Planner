
//  SignupViewModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/14/24.
//

import Foundation
import Combine
import SwiftUI


class SignUpViewModel: ObservableObject {
    @Published var navigateToBudgetSelect = false

    @Published var userName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPw = ""
    
    @Published var isUserNameValid = false
    @Published var isEmailCriteriaValid = false
    @Published var isPasswordCriteriaValid = false
    @Published var isPasswordConfirmValid = false
 
    
    @Published var canSubmit = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    //NSPredicate is logical condition used to filter data 
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,}$")
    
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*\\d)(?=.*[~!@#$%^&*()_+=\\-{}|\\[\\]:;\"<>,.?\\/])[A-Za-z\\d~!@#$%^&*()_+=\\-{}|\\[\\]:;\"<>,.?\\/]{8,}$")

    
    init() {
        
        $userName
            .map { !$0.isEmpty }
            .assign(to: \.isUserNameValid, on: self)
            .store(in: &cancellableSet)
        
        $email
            .map { self.emailPredicate.evaluate(with: $0) }
            .assign(to: \.isEmailCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        $password
            .map { self.passwordPredicate.evaluate(with: $0) }
            .assign(to: \.isPasswordCriteriaValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $confirmPw)
            .map { $0 == $1 }
            .assign(to: \.isPasswordConfirmValid, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest4($isEmailCriteriaValid, $isPasswordCriteriaValid, $isPasswordConfirmValid, $isUserNameValid)
            .map { $0 && $1 && $2 && $3 }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
       
    var userNamePrompt : String {
        isUserNameValid ?
            ""
            :
            "Please enter your name"
    }
    
    var confirmPwPrompt: String {
        isPasswordConfirmValid ?
            ""
            :
            "Password fields to not match"
    }
    
    var emailPrompt: String {
        isEmailCriteriaValid ?
            ""
            :
            "Enter a valid email address"
    }
    
    var passwordPrompt: String {
        isPasswordCriteriaValid ?
            ""
            :
            "minimum of 8 characters containing at least one number, one letter and one special character."
    }
    
    func createAccount(navigateToBudgetSelect: Binding<Bool>) {
   
        guard canSubmit else {
            return
        }
        
        print("Creating Account \(email).")
        userName = ""
        email = ""
        password = ""
        confirmPw = ""
       
        // Reset the button press status after account creation
        //isButtonPressed = false
        navigateToBudgetSelect.wrappedValue = true
      
    }
}
