//
//  RegistrationView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Register") {
                // Handle user registration
            }
            .padding()
        }
        .padding()
        .navigationTitle("Register")
    }
}


struct RegistrationView_Previews: PreviewProvider{
    static var previews: some View{
        RegistrationView()
    }
}
