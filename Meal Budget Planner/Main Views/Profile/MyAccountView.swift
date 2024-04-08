//
//  MyAccountView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/13/24.
//

import SwiftUI

struct MyAccountView: View {
    @State var isDarkModeEnabled: Bool = true
    @State var downloadViaWifiEnabled: Bool = false
        
        var body: some View {
            NavigationView {
                Form {
                    Group {
                        HStack{
                            Spacer()
                            VStack {
                                Image("Account")
                                    .resizable()
                                    .frame(width:100, height: 100, alignment: .center)
                                    .background(Color("PrimaryColor"))
                                    .clipShape(Circle())
                                Text("User Name")
                                    .font(.title)
                                Text("username@yahoo.com")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Button(action: {
                                    print("Edit Profile tapped")
                                }) {
                                    Text("Edit Profile")
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .font(.system(size: 18))
                                        .padding()
                                        .foregroundColor(.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.white, lineWidth: 2)
                                        )
                                }
                                .background(Color("PrimaryColor"))
                                .cornerRadius(25)
                            }
                            Spacer()
                        }
                    }
                    
                    Section(header: Text("CONTENT"), content: {
                        HStack{
                            Image(systemName: "heart.fill")
                            Text("Favorites")
                        }

                        HStack{
                            Image(systemName: "heart.fill")
                            Text("History")
                        }

                    })

                    Section(header: Text("PREFRENCES"), content: {
                        /*HStack{
                            Image(systemName: "heart.fill")
                            Text("Language")
                        }*/
                        HStack{
                            Image(systemName: "heart.fill")
                            Toggle(isOn: $isDarkModeEnabled) {
                                Text("Dark Mode")
                            }
                        }
                        
                       

                    })
                    
                    VStack {
                        
                        NavigationLink(
                            
                            destination:LoginView().navigationBarHidden(true),
                            label:{
                                
                                Text("Log Out")
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(.white)
                                    
                                    
                            }
                        
                        )
                        .background(Color("PrimaryColor"))
                        .cornerRadius(25)
                        
                        
                        
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Profile") 
                }
                }
                
                //.navigationBarTitle("Settings")
            // .navigationBarBackButtonHidden(true)

            }
            
        
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView()
    }
}
