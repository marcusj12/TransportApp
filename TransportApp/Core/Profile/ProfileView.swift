//
//  ProfileView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//

//import SwiftUI
//
//struct ProfileView: View {
//    @EnvironmentObject var viewModel: AuthViewViewModel
//    var body: some View {
//        if let user = viewModel.currentUser{
//            List {
//                Section {
//                   // HStack {
//                        Text(user.initials)
//                            .font(.title)
//                            .fontWeight(.semibold)
//                            .frame(width: 72, height: 72)
//                            .background(Color(.systemGray3))
//                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                        
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text(user.name)
//                                .font(.subheadline)
//                                .fontWeight(.semibold)
//                                .padding(.top, 4)
//                            
//                            Text(user.email)
//                                .font(.footnote)
//                                .accentColor(.gray)
//                        }
//                    //}
//                }
//            }
//                Section("General") {
//                  ZStack {
//                        SettingsRowView(imageName: "gear",
//                                        title: "Version",
//                                        tintColor: Color(.systemGray))
//                        
//                        Spacer()
//                        
//                        Text("1.0")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }
//                }
//                
//                Section("Account"){
//                    Button{
//                        viewModel.signOut()
//                    } label: {
//                        SettingsRowView(imageName: "arrow.left.circle.fill",
//                                        title: "Sign Out",
//                                        tintColor: .red)
//                    }
//                    
//                    Button{
//                        print("Delete Account")
//                        viewModel.deleteAccount()
//                    } label: {
//                        SettingsRowView(imageName: "xmark.circle.fill",
//                                        title: "Delete Account",
//                                        tintColor: .red)
//                        
//                    }
//                }
//            }
//        }
//    }
////}
//
//#Preview {
//    ProfileView()
//}

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                
                Section("General") {
                    SettingsRowView(imageName: "gear",
                                    title: "Version",
                                    tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("1.0")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill",
                                        title: "Sign Out",
                                        tintColor: .red)
                    }
                    
                    Button {
                        viewModel.deleteAccount()
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill",
                                        title: "Delete Account",
                                        tintColor: .red)
                    }
                }
            }
            .navigationTitle("Profile")
        } else {
            Text("Loading user data...")
                .onAppear {
                    Task {
                        await viewModel.fetchUserData()
                    }
                }
        }
    }
}

#Preview {
    ProfileView()
}

