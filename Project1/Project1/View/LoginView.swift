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
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Login") {
                    authManager.login(username: username, password: password)
                }
            }
            .navigationTitle("Login")
//            .navigationDestination(for: Bool.self) { _ in
//                HomeView(viewModel: HomeViewModel())
//            }
            
        }
//        .navigationDestination(isPresented: $isAuthenticated) {
//            MainContentView()
//        }
    }
}



struct LoginView_Previews: PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}
