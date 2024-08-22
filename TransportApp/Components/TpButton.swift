//
//  TpButton.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//

import SwiftUI

struct TpButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action){
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

#Preview {
    TpButton(title: "LogIn",
             background: .orange) {
            //Action
    }
}
