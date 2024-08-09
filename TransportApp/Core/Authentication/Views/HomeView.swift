//
//  HomeView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/5/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("Home")
            .tabItem {
                Label("Home", systemImage: "house")
            }
        }
    }
}

#Preview {
    HomeView()
}
