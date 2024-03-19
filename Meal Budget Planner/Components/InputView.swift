//
//  InputView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/12/24.

// <-----------------------NOT BEING USED ------------------------->

import SwiftUI

struct InputView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if(isSecureField){
                SecureField(placeholder, text : $text)
                    .font(.system(size: 14))
                
            }else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
                
            }
            Divider()
            
           /* if let error = validationError{
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            */
        }
        //.padding(.horizontal)
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
    }
}


