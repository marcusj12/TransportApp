//
//  DriverMainView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/15/24.
//

import SwiftUI

struct DriverMainView: View {
    var body: some View {
        TabView {
            DriverProfileView() // The check-in page for drivers
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
            
            CheckInView() // Driver's profile
                .tabItem {
                    
                    Label("Check-In", systemImage: "checkmark.circle")
                }
        }
    }
}

#Preview {
    DriverMainView().environmentObject(AuthViewViewModel())
}

