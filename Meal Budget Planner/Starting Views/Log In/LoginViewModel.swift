//
//  LoginViewModel.swift
//  Meal Budget Planner
//
//  Created by Oscar Navarro on 3/18/24.
//

import Foundation
import Firebase
import CommonCrypto
import UIKit

// ViewModel responsible for handling login logic
class LoginViewModel: ObservableObject{
    
    // Published property to track authentication status
    @Published var isAuthenticated: Bool = false
    //creates salt variable and assigns it a random string value only known by admin
    @Published var salt: String = "Turtle"
    // creates variable to track number of login attempts
    @Published var failedAttempts: Int = 0
    @Published var lockAccount: Bool = false
    
    var ref: DatabaseReference!
    
    // Initialize the ViewModel and set up Firebase reference
    init(){
        ref = Database.database().reference()
    }
    
    func hashPasswordSHA256(enteredPassword: String, salt: String) -> String? {
        // Combine entered password and salt
        let combinedString = enteredPassword + salt
        
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
    
    
    // Function to log in the user with provided email and password
    func loginUser(email: String, password: String) {
        // Reference to the "Users" node in the database
        let userref = Database.database().reference().child("Users")
        
        // Observe a single event of the "Users" node
        userref.observeSingleEvent(of: .value) { snapshot in
            guard snapshot.exists() else {
                // If no users found in the database, print a message and return
                print("No users found in the database")
                return
            }
            
            // Iterate through each child node under "Users"
            for child in snapshot.children {
                guard let userDataSnapshot = child as? DataSnapshot,
                      let userData = userDataSnapshot.value as? [String: Any],
                      let userEmail = userData["Email"] as? String,
                      let userPassword = userData["Password"] as? String,
                      let userID = userData["User ID"] as? String else {
                    // If data for user cannot be retrieved, continue to the next iteration
                    continue
                }
                let hashedPass = self.hashPasswordSHA256(enteredPassword: password, salt: self.salt)
                // Check if the provided email and password match the user's data
                if email == userEmail && hashedPass == userPassword && self.lockAccount == false{
                    // Login successful
                    print("Login successful for user ID: \(userID)")
                    self.isAuthenticated = true
                    UserManager.shared.userID = "User \(userID)"
                    return
                }
            }
            
            // Login failed
            print("Invalid email or password")
            
            // Function to track invalid attempts and lock account. After 3 wrong attempts 30 second time out.
            self.failedAttempts += 1
            if self.failedAttempts >= 3{
                //creates alert to let user know account is locked
                let alertController = UIAlertController(title: "Account Locked", message: "Your account has been locked for 30 seconds due to multiple failed login attempts. Please try again later.", preferredStyle: .alert)
                    
                    // Add an OK action to dismiss the alert
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    // Get the root view controller of the key window scene
                    guard let keyWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let rootViewController = keyWindowScene.windows.first?.rootViewController else {
                        return
                    }
                    
                    // Present the alert
                    rootViewController.present(alertController, animated: true, completion: nil)
                
                self.lockAccount = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                    // Reset the user lock flag after the lockout period
                    self.lockAccount = false
                    print("User account has been unlocked.")
                    
                    // creates alert to let user know account is unlocked
                    let unlockAlertController = UIAlertController(title: "Account Unlocked", message: "Your account has been unlocked.", preferredStyle: .alert)
                                unlockAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                
                                // Present the unlock alert
                                rootViewController.present(unlockAlertController, animated: true, completion: nil)
                    
                    
                }
            }
        }
    }
    
    
}
