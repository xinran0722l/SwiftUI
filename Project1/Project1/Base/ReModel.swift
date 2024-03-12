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
struct Category: Identifiable, Hashable, Convertable {
    var id: UUID = UUID()
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

// Ingredient Model
struct Ingredient: Identifiable, Hashable, Convertable {
    var id: UUID = UUID()
    var name: String
    var imageName: String // Reference to an image asset
    var unit: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageName
        case unit
    }
}

// RecipeIngredient (Join Model between Recipe and Ingredient)
struct RecipeIngredient: Identifiable, Hashable, Convertable {
    
    var id: UUID = UUID()
//    var recipeID: UUID // This would be used to link to the actual Recipe
    var ingredient: Ingredient
    var quantity: String
    
    enum CodingKeys: String, CodingKey {
        case ingredient
        case quantity
    }
}

// Recipe Model
struct Recipe: Identifiable, Convertable {
    var id: UUID = UUID()
    var name: String
    var isFavorite: Bool = false
    var descriptions: String
    var instruction: String
    var categories: [Category] // Many-to-many relationship to Category
    var ingredients: [RecipeIngredient] // One-to-many relationship to RecipeIngredient
    //var imageName: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case descriptions = "desc"
        case instruction
        case categories
        case ingredients
    }
    
    static func empty() -> Recipe{
        return Recipe(name: "", descriptions: "", instruction: "", categories: [], ingredients: [])
    }
    
}

struct RecipeCollect: Convertable {
    
    var recipe: String
    var userId: String
    var updateTime: Int
    
    enum CodingKeys: String, CodingKey {
        case recipe
        case userId
        case updateTime
    }
    
}

