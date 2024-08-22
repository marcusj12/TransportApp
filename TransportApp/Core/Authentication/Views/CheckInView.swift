//
//  CheckInView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/15/24.
//

import SwiftUI
import FirebaseFirestore

struct CheckInView: View {
    @EnvironmentObject var viewModel: AuthViewViewModel
    @State private var checkedInRiders: [User] = []

    var body: some View {
        VStack {
            if let currentUser = viewModel.currentUser {
                Text("Welcome, \(currentUser.name)")
                Button("Check In") {
                    Task {
                        await checkInRider()
                    }
                }
            }
            else {
                Text("Loading...")
            }
        }
        .padding()
    }
    
    private func checkInRider() async {
        guard let uid = viewModel.userSession?.uid else {
            return
        }
        do {
            let checkInData: [String: Any] = [
                "checkedIn": true,
                "timestamp": Timestamp()
            ]
            try await Firestore.firestore().collection("checkins").document(uid).setData(checkInData)
        } catch {
            print("DEBUG: Failed to check in with error \(error.localizedDescription)")
        }
    }
    
    private func fetchCheckedInRiders() async {
        do {
            let snapshot = try await Firestore.firestore().collection("checkins")
                .whereField("checkedIn", isEqualTo: true)
                .getDocuments()
            
            self.checkedInRiders = snapshot.documents.compactMap { document in
                try? document.data(as: User.self)
            }
        } catch {
            print("DEBUG: Failed to fetch checked-in riders with error \(error.localizedDescription)")
        }
    }
}

#Preview {
    CheckInView().environmentObject(AuthViewViewModel())
}


