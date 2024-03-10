//
//  SettingView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: "isLoggedIn")
                // Redirect to login view
            }
            // Toggle for measurement system, etc.
        }
    }
}
