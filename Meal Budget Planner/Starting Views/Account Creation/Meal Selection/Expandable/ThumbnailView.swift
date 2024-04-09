//
//  ThumbnailView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/9/24.
//

import SwiftUI


struct ThumbnailView: View, Identifiable {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

