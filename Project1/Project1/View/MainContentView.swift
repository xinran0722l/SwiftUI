//
//  MainContentView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}
