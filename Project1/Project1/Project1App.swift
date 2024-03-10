//
//  Project1App.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import SwiftUI

@main
struct Project1App: App {
    @StateObject private var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
//            NavigationStack {
//                if UserDefaults.standard.bool(forKey: "isLoggedIn") {
//                    MainContentView()
//                } else {
//                    LoginView()
//                }
//            }
            if authManager.isAuthenticated {
                MainContentView()
                    .environmentObject(authManager)
            } else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
    }
}
