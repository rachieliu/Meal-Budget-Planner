
//  SignupViewModel.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/14/24.
//

import Foundation
import Combine
import SwiftUI
import FirebaseCore
import FirebaseDatabase
import CommonCrypto

class UserManager{
    static let shared = UserManager()
    var userID: String = ""
    private init(){}
    
}

class SignUpViewModel: ObservableObject {
    
    var ref: DatabaseReference!
    @Published var salt = "Turtle"
    
    
    // Published properties for handling user input and validation
    @Published var errorMessage: String = ""
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
    
    

    
    let symbolPredicate = NSPredicate(format: "SELF MATCHES %@", "^[^<>&\"]*$") //to reject symbols < > & "
    let namePredicate = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z ]+$")//NSPredicate is logical condition used to filter data
   
    
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,}$")
    
    
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z])(?=.*\\d)(?=.*[~!@#$%^&*()_+=\\-{}|\\[\\]:;\"<>,.?\\/])[A-Za-z\\d~!@#$%^&*()_+=\\-{}|\\[\\]:;\"<>,.?\\/]{8,}$")

    
    func hashPasswordSHA256(password: String, salt: String) -> String? {
        // Combine password and salt
        let combinedString = password + salt
        
        // Convert the combined string to data
        guard let data = combinedString.data(using: .utf8) else {
            return nil
        }
        
        // Create a buffer to store the hashed value
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        // Generate the SHA-256 hash
        data.withUnsafeBytes { bytes in
            _ = CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
        }
        
        // Convert the hash to a hexadecimal string
        let hashedPassword = hash.map { String(format: "%02x", $0) }.joined()
        
        return hashedPassword
    }
    
    // Initializer
    init() {
        ref = Database.database().reference()
        
        // Combine latest publisher for field validation
        $userName
            .map { self.namePredicate.evaluate(with: $0) } // Check if the name matches the regex pattern
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
    
    //Prompt/error messages
    var userNamePrompt : String {
        isUserNameValid ?
            ""
            :
            "Please enter a valid name"
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
            "Please enter a valid email address"
    }
    
    var passwordPrompt: String {
        isPasswordCriteriaValid ?
            ""
            :
            "Minimum of 8 characters containing at least 1 number, 1 Capital letter and 1 special character."
    }
    
    // Function to create an account
    func createAccount(navigateToBudgetSelect: Binding<Bool>) {
   
        guard canSubmit else {
            return
        }
        // Call function to push new user data to Firebase
        pushNewValue(name: userName, email: email, password: password)
        
        print("Creating Account \(email).")
        // Reset fields after successful account creation
        userName = ""
        email = ""
        password = ""
        confirmPw = ""
       
        // Set navigation flag to transition to budget selection view
        navigateToBudgetSelect.wrappedValue = true
      
    }
    
    // Function to push new user data to Firebase
    func pushNewValue(name:String, email:String, password:String){
        
        // Variable to hold user count
        var nOfUser = 0
        
        let userRef = ref.child("Users")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
                    // Check if the snapshot exists and contains data
                    guard snapshot.exists(), let usersDict = snapshot.value as? [String: Any] else {
                        print("No data found under Users node")
                        self.ref.child("Users").child("User 0").setValue(["User ID": String(nOfUser),"Full Name": name, "Email": email, "Password": password, "Budget":0 ])
                        
                        return
                    }
                    
                    // Get the count of child nodes under "Users"
                    let numberOfUsers = usersDict.count
                    print("Number of users: \(numberOfUsers)")
                    nOfUser = numberOfUsers
            
                    let userNum = "User "  + String(nOfUser)
                    UserManager.shared.userID = String(userNum)
            
            let hashedPassword = self.hashPasswordSHA256(password: password, salt: self.salt)

            //instead of of using userNum to label the Jason object we can just use nOfUser, which is the same as UID
            self.ref.child("Users").child(userNum).setValue(["User ID": String(nOfUser),"Full Name": name, "Email": email, "Password": hashedPassword, "Budget":0 ])
            
                }
        
    }
    
    func getUserUID(completion: @escaping (String) -> Void) {
        
        let userRef = ref.child("Users")
        
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            // Check if the snapshot exists and contains data
            guard snapshot.exists(), let usersDict = snapshot.value as? [String: Any] else {
                print("No data found under Users node")
                let uid = "User 0" // Set default value for UID
                completion(uid) // Call the completion handler with the default value
                return
            }

            // Get the count of child nodes under "Users"
            let numberOfUsers = usersDict.count
            print("Number of users: \(numberOfUsers)")
            let uid = "User "  + String(numberOfUsers)
            completion(uid) // Call the completion handler with the obtained UID
            
            
        }
    }
    
    // Function to check if field contains valid characters
    func isFieldValid(_ field: String) -> Bool {
        return symbolPredicate.evaluate(with: field)
    }
    
}
