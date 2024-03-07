//
//  ValidationManager.swift
//  SwiftUICattery
//
//  Created by Xinran Yu on 3/6/24.
//

import SwiftUI
class ValidationManager: ObservableObject {
    @Published var isInputValid: Bool = false
    @Published var numFailedAttempts: Int = 0

    func validateInput(_ input: String) {
        let hasValidLength = input.count >= 4
        let containsAlphabet = input.rangeOfCharacter(from: .letters) != nil
        isInputValid = hasValidLength && containsAlphabet
        
        if isInputValid {
            numFailedAttempts = 0
        } else {
            numFailedAttempts += 1
        }
    }
}
