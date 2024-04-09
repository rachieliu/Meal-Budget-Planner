//
//  ExpandedView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 4/9/24.
//

import SwiftUI

struct ExpandedView: View {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}
