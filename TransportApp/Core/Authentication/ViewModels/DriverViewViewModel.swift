//
//  DriverViewViewModel.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/14/24.
//

import Foundation


import SwiftUI

class DriverViewModel: ObservableObject {
    @Published var users: [BusUser] = [
        BusUser(id: 1, name: "John Doe", isCheckedIn: false),
        BusUser(id: 2, name: "Jane Smith", isCheckedIn: false)
    ]

    func checkInUser(_ user: BusUser) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index].isCheckedIn.toggle()
        }
    }
}
 
