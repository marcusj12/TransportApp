//
//  RegisterView.swift
//  TransportApp
//
//  Created by Marcus  Jennings on 8/1/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State var errorMessage = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject  var viewModel : AuthViewViewModel
    
    var body: some View {
        
        VStack {
            //Header
            HeaderView(title: "Register Here",
                       subtitle: "Let's Get Started",
                       angle: -15,
                       background: .yellow)
            
            Form{
                TextField("Full Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                
                TextField("Email Address", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                    
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword {
                            Image(systemName: "checkmarck.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                            
                        }
                }
                
                TpButton(title: "Create Account", background: .orange){
                    Task{
                        try await viewModel.createUser(withEmail: email, password: password, name: name)
                    }
                  
                }
                .padding()
            }
            .offset(y: -50)
            
            Spacer()
        }
    }
}

extension RegisterView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 6
        && confirmPassword == password
    }
}

#Preview {
    RegisterView()
}
