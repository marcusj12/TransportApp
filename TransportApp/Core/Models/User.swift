//
//  User.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let name: String
    let email: String
    let role: String // Added role property
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}


//extension User {
//    static var MOCK_USER = User(id: id, name: name, email: email)
//    
//}
