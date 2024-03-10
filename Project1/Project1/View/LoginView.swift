//
//  LoginView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import SwiftUI
import Foundation



struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Login") {
                    // Perform login validation...
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    isAuthenticated = true
                }
            }
            .navigationTitle("Login")
//            .navigationDestination(for: Bool.self) { _ in
//                HomeView(viewModel: HomeViewModel())
//            }
            
        }
        .navigationDestination(isPresented: $isAuthenticated) {
            MainContentView()
        }
    }
}



struct LoginView_Previews: PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}
