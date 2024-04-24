//
//  SwiftUIView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/23/24.
//
import SwiftUI

class Coordinator: NSObject, ObservableObject {
    @Published var shouldShowLoginView = false
    
    func navigateToLoginView() {
        shouldShowLoginView = true
        print("Logging out...")
    }
}
