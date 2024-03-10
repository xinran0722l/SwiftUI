//
//  authManager.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//
import SwiftUI

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool
    @Published var username: String = ""
    init() {
        // Initialize isAuthenticated based on persistent storage
        isAuthenticated = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    func login(username: String, password: String) {
        self.username = username
        isAuthenticated = true
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
    }

    func logout() {
        isAuthenticated = false
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}

