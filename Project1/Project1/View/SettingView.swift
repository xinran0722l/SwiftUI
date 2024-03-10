//
//  SettingView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        Form {
            Button("Logout") {
                authManager.logout()
                // Redirect to login view
            }
            // Toggle for measurement system, etc.
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider{
    static var previews: some View{
        SettingsView()
    }
}
