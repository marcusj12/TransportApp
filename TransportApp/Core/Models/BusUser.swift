//
//  BusUser.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/15/24.
//

import Foundation

struct BusUser: Identifiable, Codable{
    let id: Int
    let name: String
    var isCheckedIn: Bool
}
