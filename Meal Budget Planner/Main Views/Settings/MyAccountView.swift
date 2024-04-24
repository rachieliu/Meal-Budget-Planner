//
//  MyAccountView.swift
//  Meal Budget Planner
//
//  Created by Rachel Liu on 2/13/24.
//

import SwiftUI


struct MyAccountView: View {
    
    
    @State var isDarkModeEnabled: Bool = false
    @ObservedObject var viewModel = MyAccountViewModel()
    @State private var navigateToLogin = false
   
    var body: some View {
        
        NavigationView {
            VStack {
                Group {
                    HStack {
                        Spacer()
                        VStack {
                            
                            Image("Account")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .background(isDarkModeEnabled ? Color("Black") : Color("BabyPink"))
                                .clipShape(Circle())
                           Text("Rachel")
                                .font(.title)
                            Text("rachelliu34@yahoo.com")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                           Text(viewModel.name)
                                .font(.title)
                            Text(viewModel.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        
                            Button(action: {
                                print("Edit Profile tapped")
                            }) {
                                Text("Edit Profile")
                                    .frame(minWidth: 0, maxWidth: 250, maxHeight:50)
                                    .font(.system(size: 18))
                                   // .padding()
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                           .background(isDarkModeEnabled ? Color("BabyBlue") : Color("GreyTone"))
                            .cornerRadius(25)
                        }
                        Spacer()
                    }
                }

                
                Form {
                                        
                    Section(header: Text("CONTENT"), content: {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(isDarkModeEnabled ? Color.black : Color("BabyPink"))
                            Text("Favorites")
                        }
                        .listRowBackground(isDarkModeEnabled ? Color("BabyBlue") : Color.white)

                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(isDarkModeEnabled ? Color.black : Color("BabyPink"))
                            Text("History")
                        }
                        .listRowBackground(isDarkModeEnabled ? Color("BabyBlue") : Color.white)
                    })

                    Section(header: Text("PREFERENCES"), content: {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color("BabyPink"))
                            Toggle(isOn: $isDarkModeEnabled) {
                                Text("Blue Mode")
                            }
                            .listRowBackground(isDarkModeEnabled ? Color("BabyBlue") : Color.white)
                        }
                    })
   
                }
                
                
                
                Button(action: {
                      viewModel.logout()
                    navigateToLogin = true
                  }) {
                      Text("Log Out")
                          .frame(maxWidth: 200, maxHeight:20)
                          .font(.system(size: 18))
                          .padding()
                          .foregroundColor(isDarkModeEnabled ? Color("LightGrey") : Color("DarkGrey"))
                          
                  }
                 
                  
                  .background(isDarkModeEnabled ? Color("DarkGrey") : Color("LightGrey"))
                 .cornerRadius(25)
                 .padding(.bottom)
                 .fullScreenCover(isPresented: $navigateToLogin) {
                                     LoginView()
                                 }
            
               
               
                
                .navigationTitle("Profile")
            
            }

          
            .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                        viewModel.getUserInfo()
                    }
                }
        }
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyAccountView()
                
          
        }
    }
}
