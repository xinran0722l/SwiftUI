//
//  ChildView.swift
//  SwiftUICattery
//
//  Created by Xinran Yu on 3/6/24.
//
import SwiftUI

struct ChildView: View {
    @Binding var cat: Cat
    @ObservedObject var validationManager: ValidationManager
    
    var body: some View {
        VStack {
            Image(cat.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding()
            
            TextField("Enter cat name", text: $cat.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: cat.name) {oldValue, newValue in
                    print("Loading image with name: \(cat.imageName)")
                    validationManager.validateInput(newValue)
                }
//                .onChange(of: cat.name) { oldValue, newValue in
//                    validationManager.validateInput(newValue)
//                }
            
            if !validationManager.isInputValid {
                Text("Invalid input. Please ensure the name has at least 4 characters and contains letters.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationTitle(cat.name)
        .padding()
    }
}


struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        ChildView(cat: .constant(Cat(name: "Preview Cat", imageName: "defaultImage")), validationManager: ValidationManager())
    }
}

