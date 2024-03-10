//
//  ReModel.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation

// User Model
struct User {
    var email: String
    var username: String
    var favorites: [Recipe] // Assuming a simple favorites system for demonstration
}

// Category Model
struct Category: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
}

// Ingredient Model
struct Ingredient: Identifiable {
    var id: UUID = UUID()
    var name: String
    var imageName: String // Reference to an image asset
    var unit: String
}

// RecipeIngredient (Join Model between Recipe and Ingredient)
struct RecipeIngredient: Identifiable {
    var id: UUID = UUID()
    var recipeID: UUID // This would be used to link to the actual Recipe
    var ingredient: Ingredient
    var quantity: Double
}

// Recipe Model
struct Recipe: Identifiable {
    var id: UUID = UUID()
    var name: String
    var isFavorite: Bool
    var descriptions: String
    var instruction: String
    var categories: [Category] // Many-to-many relationship to Category
    var ingredients: [RecipeIngredient] // One-to-many relationship to RecipeIngredient
    //var imageName: String
}
