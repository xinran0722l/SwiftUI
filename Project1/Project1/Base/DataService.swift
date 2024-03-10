//
//  DataService.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation


class DataService {
    // Singleton instance for simplicity
    static let shared = DataService()
    private var categories: [Category] = []
    
    private init() {
        categories = fetchCategories()
        
    }

    func fetchCategories() -> [Category] {
        // Simulate fetching categories
        return [
            Category(id:UUID(), name: "Breakfast"),
            Category(id:UUID(), name: "Vegetarian"),
            // Add more categories as needed
        ]
    }

    func fetchRecipes() -> [Recipe] {
        // Simulate fetching recipes
        let breakfastCategory = categories.first { $0.name == "Breakfast" }
        let vegetarianCategory = categories.first { $0.name == "Vegetarian" }

        return [
            Recipe(name: "Pancakes", isFavorite: false, description: "Delicious breakfast pancakes.", instruction: "Mix and cook.", categories: breakfastCategory != nil ? [breakfastCategory!] : [], ingredients: []),
            Recipe(name: "Vegetarian Pizza", isFavorite: false, description: "A tasty vegetarian pizza.", instruction: "Prepare dough, add toppings, and bake.", categories: vegetarianCategory != nil ? [vegetarianCategory!] : [], ingredients: [])
            // Add more recipes as needed
        ]
    }
}
