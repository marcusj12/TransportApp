//
//  RiderMainView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/15/24.
//

import SwiftUI

struct RiderMainView: View {
    @EnvironmentObject var viewModel: AuthViewViewModel
    
    var body: some View {
        TabView {
            RiderProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            
            GPSView() // Assuming you have a GPSView
                .tabItem {
                    Label("GPS", systemImage: "location.circle")
                }
        }
    }
}

#Preview {
    RiderMainView().environmentObject(AuthViewViewModel())
}

