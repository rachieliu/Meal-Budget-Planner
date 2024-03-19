//
//  HeaderView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 3/18/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Image("Icon")
                    .resizable()
                    .frame(width: 150, height: 120)
                    .padding(.top, 20)
                    .padding(.leading, 60) // Adjusted padding for right spacing
                Spacer()
                
                NavigationLink(destination: MyAccountView()) {
                    Image("Account")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                        .background(Color("PrimaryColor"))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            .padding(.top, -50)
        }
        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top) // Use safeAreaInsets
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
