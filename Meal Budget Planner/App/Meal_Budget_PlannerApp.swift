//
//  Meal_Budget_PlannerApp.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/9/24.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth


class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
      FirebaseApp.configure()
      return true

  }

}



@main
struct Meal_Budget_PlannerApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
