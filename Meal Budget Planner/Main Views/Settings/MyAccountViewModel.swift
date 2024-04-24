//
//  MyAccountViewModel.swift
//  Meal Budget Planner
//
//  Created by Oscar Navarro on 4/15/24.
//

import Foundation
import Firebase


class MyAccountViewModel: ObservableObject{
    
    var ref: DatabaseReference!
    init(){
        ref = Database.database().reference()
    }
    
    @Published var name: String = ""
    @Published var email: String = ""
    
    func getUserInfo(){
        let userNum = UserManager.shared.userID
        
        ref.child("Users").child(userNum).observeSingleEvent(of: .value) { (snapshot) in
                if let userData = snapshot.value as? [String: Any] {
                    if let userName = userData["Full Name"] as? String {
                        print("User Name: \(userName)")
                        self.name = userName
                    }
                    if let userEmail = userData["Email"] as? String {
                        print("Email: \(userEmail)")
                        self.email = userEmail
                    }
                } else {
                    print("User data not found")
                }
            }
    }
    
    func logout(){
        UserManager.shared.userID = ""
        print("User logged out")
    }
    
    
    
    
}
