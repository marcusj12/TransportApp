//
//  TransportAppApp.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 7/31/24.
//
import FirebaseCore
import SwiftUI

@main
struct TransportAppApp: App {
    @StateObject var viewModel = AuthViewViewModel()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
