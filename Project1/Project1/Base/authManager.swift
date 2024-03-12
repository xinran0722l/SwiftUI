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
    
    static let shared = AuthManager()
    
    private init() {
        // Initialize isAuthenticated based on persistent storage
        isAuthenticated = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if let username = UserDefaults.standard.string(forKey: "loggedUsername"), username.count > 0{
            self.username = username
        } else {
            isAuthenticated = false
        }
    }

    func login(username: String, password: String) {
        self.username = username
        isAuthenticated = true
        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        UserDefaults.standard.set(username, forKey: "loggedUsername")
        UserDefaults.standard.synchronize()
    }

    func logout() {
        isAuthenticated = false
        username = ""
        UserDefaults.standard.set("", forKey: "loggedUsername")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
    }
}


