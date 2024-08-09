//
//  SettingsRowView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/7/24.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
 
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}


#Preview {
    SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
}
