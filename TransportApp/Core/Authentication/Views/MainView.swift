//
 //  ContentView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 7/31/24.
//

//import SwiftUI
//
//struct MainView: View {
//    @StateObject var viewModel = MainViewViewModel()
//    
//    var body: some View {
//        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
//            accountView
//        } else {
//            LoginView()
//        } 
//    }
//    @ViewBuilder
//    var accountView: some View {
//        TabView{
////            HomeView()
////                .tabItem {
////                    Label("Home", systemImage: "house")
////                }
//            ProfileView()
//                .tabItem {
//                    Label("Profile", systemImage: "person.circle" )
//                }
//            GpsView()
//                .tabItem {
//                    Label("GPS", systemImage: "map.circle")
//                }
//        }
//    }
//}
//
//#Preview {
//
//    MainView()
//    
//}
//    

import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewModel: AuthViewViewModel
    
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            
            GpsView() // Assuming you have a GPSView
                .tabItem {
                    Label("GPS", systemImage: "location.circle")
                }
        }
    }
}

#Preview {
    MainView()
}

