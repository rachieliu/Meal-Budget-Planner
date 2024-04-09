//
//  LoginViewModel.swift
//  Meal Budget Planner
//
//  Created by Oscar Navarro on 3/18/24.
//

import Foundation
import Firebase

class LoginViewModel: ObservableObject{
    
    var ref: DatabaseReference!
    
    init(){
        ref = Database.database().reference()
    }
    
    
    func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        print("Hello")
            ref.child("Users").observeSingleEvent(of: .value) { snapshot in
                guard snapshot.exists(), let usersDict = snapshot.value as? [String: [String: Any]] else {
                    completion(false) // No data found
                    return
                }
                
                var isAuthenticated = false
                
                // Iterate through user data to find a matching email
                for (_, userData) in usersDict {
                    if let userEmail = userData["email"] as? String, userEmail == email {
                        // Email found, now check password
                        if let storedPassword = userData["password"] as? String, storedPassword == password {
                            print("worked")
                            isAuthenticated = true // Email and password match
                            break
                        }
                    }
                }
                print("did not work")
                completion(isAuthenticated)
            }
        }
    
    
    
    
}
