//
//  EditReView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import SwiftUI

struct AddEditRecipeView: View {
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var selectedCategories: [Category] = [] // Assuming you have a way to manage category selection
    @State private var ingredientName: String = ""
    @State private var ingredientQuantity: String = ""
    // Assuming a simplistic approach for ingredient unit (you may want to use a picker for real cases)
    @State private var ingredientUnit: String = ""
    
    // Dummy categories for demonstration. Replace with your data source.
    let availableCategories: [Category] = [
        Category(name: "Breakfast"),
        Category(name: "Dinner")
    ]

    var body: some View {
        Form {
            LimitedTextField(label: "Recipe Name", text: $recipeName, maxLength: 50)
            LimitedTextField(label: "Description", text: $recipeDescription, maxLength: 250)
            
            Section(header: Text("Categories")) {
                // Assuming you have a predefined list of categories
                ForEach(availableCategories, id: \.self) { category in
                    MultipleSelectionRow(title: category.name, isSelected: selectedCategories.contains(category)) {
                        if selectedCategories.contains(category) {
                            selectedCategories.removeAll(where: { $0 == category })
                        } else {
                            selectedCategories.append(category)
                        }
                    }
                }
            }
            
            Section(header: Text("Add Ingredient")) {
                TextField("Ingredient Name", text: $ingredientName)
                TextField("Quantity", text: $ingredientQuantity)
                    .keyboardType(.decimalPad)
                TextField("Unit", text: $ingredientUnit)
                Button("Add Ingredient") {
                    // Add logic to append ingredient to a list
                }
            }
            
            Button("Save Recipe") {
                // Save or update the recipe logic here
            }
        }
        .navigationTitle("Edit Recipe")
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
        .foregroundColor(.black)
    }
}

struct LimitedTextField: View {
    var label: String
    @Binding var text: String
    var maxLength: Int
    
    var body: some View {
        TextField(label, text: $text)
            .onChange(of: text) {
                if text.count > maxLength {
                    text = String(text.prefix(maxLength))
                }
            }
    }
}
