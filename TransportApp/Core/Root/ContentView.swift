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
                ProfileView()
            } else {
                LoginView()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
