//
//  LoginViewViewModel.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.

// Creating an abstraction of the regular views
//import FirebaseAuth // providing functionality for authorization of password and email
//import Foundation
//class LoginViewViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var errorMessage = ""
//    @Published var confirmPassword = ""
//    
//    init() {}
//    
//    func login() {
//        guard validate() else{
//            return
//        }
//        
//        //Try Log in
//        Auth.auth().signIn(withEmail: email, password: password)
//    }
//    //Validation methods
//    // Email requires @ sign and Periods(.)
//    // Validate the password and Emaily
//    private func validate() -> Bool {
//        errorMessage = ""
//        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
//              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
//            errorMessage = "Please fill in all fields"
//            return false
//        }
//        
//        guard email.contains("@") && email.contains(".") else {
//            errorMessage = "Please enter correct credentials"
//            return false
//        }
//        return true
//    }
//}
// 
