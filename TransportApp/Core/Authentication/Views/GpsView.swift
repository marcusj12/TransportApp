//
//  GpsView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//

import SwiftUI

struct GpsView: View {
    @StateObject var viewModel = GpsViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("GPS")
        }
    }
}
#Preview {
    GpsView()
}

