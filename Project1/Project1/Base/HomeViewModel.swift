//
//  HomeViewModel.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//


import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var categories: [Category] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
            self.categories = DataService.shared.fetchCategories()
            self.recipes = DataService.shared.fetchRecipes()
    }

    func loadCategories() {
        // Here you'd fetch categories from your data source (e.g., CoreData, network, etc.)
        // This is a placeholder implementation
        categories = [
            Category(name: "Breakfast"),
            Category(name: "Vegetarian")
        ]
    }

    func loadRecipes() {
        // Similar to loadCategories, you'd fetch recipes here.
        // Placeholder implementation
        let breakfast = Category(name: "Breakfast")
        recipes = [
            Recipe(name: "Pancakes", description: "Delicious breakfast pancakes.", instruction: "Mix and cook.", categories: [breakfast], ingredients: [])
            // Add more recipes
        ]
    }
}
