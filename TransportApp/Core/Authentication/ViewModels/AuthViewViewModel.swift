//
//  AuthViewViewModel.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/7/24.
// Responsible for all authentication, updating UI

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var selectedRole: String?// To Store the role of the user
    
    init(){
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUserData()
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUserData() // Ensure user data is fetched after sign-in
        } catch {
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, name: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, name: name, email: email, role: selectedRole ?? "Rider")
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUserData() // Fetch user data after creating a new user
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            self.selectedRole = nil
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        // Implement account deletion logic
    }
    
    func fetchUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Debug: No user is signed in")
            return
        }
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            
            guard snapshot.data() != nil else{
                print("DEBUG: No user data found")
                signOut()
                return
            }
            
            self.currentUser = try snapshot.data(as: User.self)
            self.selectedRole = currentUser?.role ?? "Rider"
            
            print("DEBUG: Successfully fetched user data. Role: \(self.selectedRole ?? "None")")
        } catch {
            print("DEBUG: Failed to fetch user data with error \(error.localizedDescription)")
            signOut()
        }
    }
    
    func navigateBasedOnRole() -> some View {
        let bindingRole = Binding<String?>(
            get: { self.selectedRole },
            set: { self.selectedRole = $0 }
        )

        if selectedRole == "Driver" {
            return AnyView(DriverMainView())
        } else if selectedRole == "Rider" {
            return AnyView(RiderMainView())
        } else {
            return AnyView(RoleSelectionView(selectedRole: bindingRole))
        }
    }
    
}

