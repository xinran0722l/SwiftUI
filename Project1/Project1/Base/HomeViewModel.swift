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
    @Published var favoriteRecipeIDs: Set<UUID> = []
    @Published var selectedCategoryIDs: Set<UUID> = []

    init() {
        refreshData()
    }
    
    func refreshData() {
        categories = DataService.shared.fetchCategories()
        recipes = DataService.shared.fetchRecipes()
    }

    func toggleCategorySelection(_ category: Category) {
        if selectedCategoryIDs.contains(category.id) {
            selectedCategoryIDs.remove(category.id)
        } else {
            selectedCategoryIDs.insert(category.id)
        }
        // Optionally, refresh the recipes list based on the new selection
    }
    
    var filteredRecipes: [Recipe] {
        // Adjust this to filter recipes based on selected categories
        print("Currently selected category IDs: \(selectedCategoryIDs)")
        guard !selectedCategoryIDs.isEmpty else { return recipes }
        return recipes.filter { recipe in
            let recipeCategoryIDs = Set(recipe.categories.map { $0.id })
            let match = !recipeCategoryIDs.isDisjoint(with: selectedCategoryIDs)
            print("recipeCategoryIDs \(recipeCategoryIDs)")
            print("selectedCategoryIDs \(selectedCategoryIDs)")
            print("match or not \(match)")
            
            if match {
                print("Recipe \(recipe.name) matches selected categories.")
            }
            return match// Meaning they have common elements
        }
    }
    
    
    func toggleFavorite(for recipe: Recipe) {
        if favoriteRecipeIDs.contains(recipe.id) {
            favoriteRecipeIDs.remove(recipe.id)
        } else {
            favoriteRecipeIDs.insert(recipe.id)
        }
    }
    func isFavorite(recipe: Recipe) -> Bool {
        favoriteRecipeIDs.contains(recipe.id)
    }

}
