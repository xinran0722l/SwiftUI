//
//  Project1App.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import SwiftUI

@main
struct Project1App: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                    HomeView(viewModel: HomeViewModel())
                } else {
                    LoginView()
                }
            }
        }
    }
}
