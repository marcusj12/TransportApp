//
 //  ContentView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 7/31/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        } 
    }
    @ViewBuilder
    var accountView: some View {
        TabView{
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle" )
                }
            GpsView()
                .tabItem {
                    Label("GPS", systemImage: "map.circle")
                }
        }
    }
}

#Preview {

    MainView()
    
}
    
