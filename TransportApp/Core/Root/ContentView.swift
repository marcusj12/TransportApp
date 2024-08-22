//
//  ContentView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/7/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var viewModel: AuthViewViewModel
//    
//    var body: some View {
//        Group {
//            if viewModel.userSession != nil {
//                MainView() // Shows the main view after logging in
//            } else {
//                LoginView() // Shows the login view if the user is not logged in
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}


//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var viewModel: AuthViewViewModel
//    @State private var selectedRole: String? = nil
//
//    var body: some View {
//        Group {
//            if selectedRole == nil {
//                // Show the RoleSelectionView if the role hasn't been selected yet
//                RoleSelectionView(selectedRole: $selectedRole)
//            } else if viewModel.userSession != nil {
//                // Show the appropriate view based on the selected role
//                if selectedRole == "Driver" {
//                    DriverMainView()
//                } else if selectedRole == "Rider" {
//                    RiderMainView()
//                }
//            } else {
//                // Show the login view if the user is not logged in
//                LoginView()
//            }
//        }
//    }
////}
//
//#Preview {
//    ContentView().environmentObject(AuthViewViewModel())
//}


//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var viewModel: AuthViewViewModel
//
//    var body: some View {
//        Group {
//            if let selectedRole = viewModel.selectedRole {
//                if selectedRole == "Driver" {
//                    DriverMainView()
//                } else if selectedRole == "Rider" {
//                    RiderMainView()
//                }
//            } else if viewModel.userSession != nil {
//                // Handle scenario where role is not selected but user is logged in
//                Text("Loading...")
//                    .onAppear {
//                        Task {
//                            await viewModel.fetchUserData()
//                        }
//                    }
//            } else {
//                LoginView() // Shows the login view if the user is not logged in
//            }
//        }
//        .onAppear{
//            if viewModel.selectedRole == nil && viewModel.userSession == nil {
//                print("DEBUG: User not signed in or role not selected")
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView().environmentObject(AuthViewViewModel())
//}


//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var viewModel: AuthViewViewModel
//
//    var body: some View {
//        Group {
//            if let selectedRole = viewModel.selectedRole{
//                 
//            }
//            if viewModel.userSession == nil {
//                // Show the RoleSelectionView when the user is not signed in
//                RoleSelectionView(selectedRole: $viewModel.selectedRole)
//            } else if let selectedRole = viewModel.selectedRole {
//                // Navigate to the appropriate main view based on the selected role
//                if selectedRole == "Driver" {
//                    DriverMainView()
//                } else if selectedRole == "Rider" {
//                    RiderMainView()
//                }
//            } else {
//                // If the user is signed in but the role is not yet selected, show the loading screen
//                Text("Loading...")
//                    .onAppear {
//                        Task {
//                            await viewModel.fetchUserData()
//                        }
//                    }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView().environmentObject(AuthViewViewModel())
//}


import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewViewModel

    var body: some View {
        Group {
            if let selectedRole = viewModel.selectedRole {
                if viewModel.userSession == nil {
                    // Show the sign-in view based on the selected role
                    LoginView()
                } else {
                    // Show the main view based on the selected role
                    if selectedRole == "Driver" {
                        DriverMainView()
                    } else if selectedRole == "Rider" {
                        RiderMainView()
                    }
                }
            } else {
                // Show the RoleSelectionView when no role is selected
                RoleSelectionView(selectedRole: $viewModel.selectedRole)
            }
        }
        .onAppear {
            // Ensure data is fetched on launch
            if viewModel.userSession != nil && viewModel.selectedRole == nil {
                Task {
                    await viewModel.fetchUserData()
                }
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewViewModel())
}
