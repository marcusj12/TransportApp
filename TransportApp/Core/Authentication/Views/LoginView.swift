  //
//  LoginView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @EnvironmentObject var viewModel: AuthViewViewModel
    

    var body: some View {
        // allows project to navigate bewtween different pages
        NavigationView{
            VStack {
                // Header
                HeaderView(title: "MicroBus",
                           subtitle: "Serving the Community",
                           angle: 15,
                           background: .blue)
                
                //Login Form
                Form {
                    
                    TextField("Email Address", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    
                   TpButton(title: "Log In",background: .blue) {
                       Task{
                           do{
                               try await viewModel.signIn(withEmail: email, password: password)
                               await viewModel.fetchUserData()
                           } catch {
                               errorMessage = error.localizedDescription
                           }
                       }
                        
                   }
                    .padding()
                }
                .offset(y: -50)
                .disabled(formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                Spacer()
                
                
                // Create Account
                VStack {// vertical stack
                    Text("New account?")
                    NavigationLink("Create a Account", destination: RegisterView()) }
                    // Show registration
                   .padding(.bottom, 50)
                    Spacer()
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
    }
}
    
#Preview {
    LoginView()
}
