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
                    .padding(.top, 50)
                   
               Spacer()
                
            }
          
        }
       
        
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
