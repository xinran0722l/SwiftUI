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

    private init() {}

    func fetchCategories() -> [Category] {
        // Simulate fetching categories
        return [
            Category(name: "Breakfast"),
            Category(name: "Vegetarian"),
            // Add more categories as needed
        ]
    }

    func fetchRecipes() -> [Recipe] {
        // Simulate fetching recipes
        let breakfast = Category(name: "Breakfast")
        let vegetarian = Category(name: "Vegetarian")

        return [
            Recipe(name: "Pancakes", description: "Delicious breakfast pancakes.", instruction: "Mix and cook.", categories: [breakfast], ingredients: []),
            Recipe(name: "Vegetarian Pizza", description: "A tasty vegetarian pizza.", instruction: "Prepare dough, add toppings, and bake.", categories: [vegetarian], ingredients: [])
            // Add more recipes as needed
        ]
    }
}
