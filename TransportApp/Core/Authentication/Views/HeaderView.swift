//
//  HeaderView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(background)
                .rotationEffect(Angle(degrees: angle))
            
            VStack {
                Text(title)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .bold()
                
                Text(subtitle)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                
            }
            .padding(.top, 30)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 400)
        .offset(y: -100)
        Spacer()
    }
}

#Preview {
    HeaderView(title: "MicroBus",
               subtitle: "Serving the Community",
               angle: 15,
               background: .blue)
}
