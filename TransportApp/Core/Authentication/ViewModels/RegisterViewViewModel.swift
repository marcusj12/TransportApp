//
//  RegisterViewViewModel.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//
//import FirebaseFirestore
//import FirebaseAuth
//import Foundation
//
//class RegisterViewViewModel: ObservableObject {
//    @Published var name = ""
//    @Published var email = ""
//    @Published var password = ""
//    @Published var errorMessage = ""
//    
//    init(){}
//    
//    func register(){
//        guard validate() else{
//            return
//        }
//        // Once user id is created, we want to insert into the database
//        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in guard let userId = result?.user.uid else {
//                return
//            }
//            self?.insertUserRecord(id: userId)
//        }
//    }
//    
//    private func insertUserRecord(id: String) {
//        let newUser = User(id: id,
//                           name: name,
//                           email: email)
//        
//        let db = Firestore.firestore()
//        
//        db.collection("users")
//            .document(id)
//            .setData(newUser.asDictionary())
//    }
//    
//    private func validate() -> Bool {
//        errorMessage = ""
//        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
//              !email.trimmingCharacters(in: .whitespaces).isEmpty,
//              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
//            errorMessage = "Please fill in all fields"
//            return false
//        }
//        
//        guard email.contains("@") && email.contains(".") else {
//            return false
//        }
//        
//        guard password.count >= 8 else {
//            return false
//            
//        }
//        return true
//    }
//}
