//
//  ContentView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                MainView() // Shows the main view after logging in
            } else {
                LoginView() // Shows the login view if the user is not logged in
            }
        }
    }
}

#Preview {
    ContentView()
}

