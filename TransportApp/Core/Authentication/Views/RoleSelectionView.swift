//
//  RoleSelectionView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/14/24.
//

//import SwiftUI
//
//struct RoleSelectionView: View {
//    @EnvironmentObject var viewModel: AuthViewViewModel
//    @Binding var selectedRole: String?
//    
//    var body: some View {
//        VStack {
//            Text("Select Your Role")
//                .font(.largeTitle)
//                .padding()
//            
//            Button(action: {
//                selectedRole = "Driver"
//                viewModel.selectedRole = "Driver"
//            }) {
//                Text("Driver")
//                    .font(.title)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .padding(.bottom, 20)
//            
//            Button(action: {
//                selectedRole = "Rider"
//                viewModel.selectedRole = "Rider"
//            }) {
//                Text("Rider")
//                    .font(.title)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//    }
//}
//
////#Preview {
////    RoleSelectionView().environmentObject(AuthViewViewModel())
////}
//#Preview {
//    RoleSelectionView(selectedRole: .constant(nil))
//        .environmentObject(AuthViewViewModel())
//}

import SwiftUI

struct RoleSelectionView: View {
    @EnvironmentObject var viewModel: AuthViewViewModel
    @Binding var selectedRole: String?
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                // Title
                Text("Select Your Role")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Driver button
                Button(action: {
                    selectedRole = "Driver"
                    viewModel.selectedRole = "Driver"
                }) {
                    HStack {
                        Image(systemName: "car.fill")
                            .font(.title)
                        Text("Driver")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
                
                // Rider button
                Button(action: {
                    selectedRole = "Rider"
                    viewModel.selectedRole = "Rider"
                }) {
                    HStack {
                        Image(systemName: "person.fill")
                            .font(.title)
                        Text("Rider")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 100)
        }
    }
}

#Preview {
    RoleSelectionView(selectedRole: .constant(nil))
        .environmentObject(AuthViewViewModel())
}
