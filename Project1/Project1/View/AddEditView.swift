//
//  EditReView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import SwiftUI

struct AddEditView: View {
    
    @Binding var recipe: Recipe
    @State private var recipeName: String = ""
    @State private var recipeDescription: String = ""
    @State private var selectedCategories: [Category] = [] // Assuming you have a way to manage category selection
    @State private var ingredientName: String = ""
    @State private var ingredientQuantity: String = ""
    // Assuming a simplistic approach for ingredient unit (you may want to use a picker for real cases)
    @State private var ingredientUnit: String = ""
    @State private var instruction: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
//    init(recipe: Binding<Recipe>) {
//        self._recipe = recipe
//    }
    
    // Dummy categories for demonstration. Replace with your data source.
    let availableCategories: [Category] = [
        Category(name: "Breakfast"),
        Category(name: "Vegetarian")
    ]

    var body: some View {
        Form {
            LimitedTextField(label: "Recipe Name", text: $recipeName, maxLength: 50)
            
            Section(header: Text("Description")) {
                TextEditor(text: $recipeDescription)
                    .frame(minHeight: 100) // Adjust based on your UI needs
                    .onChange(of: recipeDescription) {
                        if recipeDescription.count > 250 {
                            recipeDescription = String(recipeDescription.prefix(250))
                        }
                    }
            }
            
            Section(header: Text("Instruction")) {
                TextEditor(text: $instruction)
                    .frame(minHeight: 100) // Adjust based on your UI needs
                    .onChange(of: instruction) {
                        if instruction.count > 250 {
                            instruction = String(instruction.prefix(500))
                        }
                    }
            }
            
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
                if (recipeName.count == 0){
                    print("Can not save empty recipe.")
                    return
                }
                Task{
                    let ingredient = RecipeIngredient(ingredient: Ingredient(name: ingredientName, imageName: "", unit: ingredientUnit), quantity: ingredientQuantity)
                    let object = Recipe(name: recipeName, descriptions: recipeDescription, instruction: instruction, categories: selectedCategories, ingredients: [ingredient])
                    let result = await DataService.shared.insertOrReplaceRecipe([object])
                    if (result){
                        print("Save successful~")
                        recipe = object
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            Button("Delete Recipe") {
                if (recipeName.count == 0){
                    print("Can not delete empty recipe.")
                    return
                }
                Task{
                    await DataService.shared.deleteRecipe([recipeName])
                    
                    print("delete successful~")
                        //recipe = object
                    presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            
        .navigationTitle("Edit Recipe")
        .onAppear {
            updateSubviews()
        }
    }
    
    func updateSubviews(){
        self.recipeName = recipe.name
        self.instruction = recipe.instruction
        self.recipeDescription = recipe.descriptions
        let currentRecipeTags = recipe.categories.map({ $0.name })
        self.selectedCategories = availableCategories.filter({ c in
            return currentRecipeTags.contains(c.name)
        })
        self.ingredientName = recipe.ingredients.first?.ingredient.name ?? ""
        self.ingredientQuantity = recipe.ingredients.first?.quantity ?? ""
        self.ingredientUnit = recipe.ingredients.first?.ingredient.unit ?? ""
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

//struct AddEditRecipeView_Previews: PreviewProvider{
//    static var previews: some View{
//        AddEditView(recipe: $Recipe(name: "Pancakes", isFavorite: false, descriptions: "Delicious breakfast pancakes.", instruction: "Mix and cook.", categories: [], ingredients: []))
//    }
//}

