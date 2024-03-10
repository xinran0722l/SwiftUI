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
        let selectedCategoryNames: Set<String> = Set(categories.filter { selectedCategoryIDs.contains($0.id) }.map { $0.name })
        return recipes.filter { recipe in
            let recipeCategoryNames = Set(recipe.categories.map { $0.name })
            return !recipeCategoryNames.isDisjoint(with: selectedCategoryNames) // True if there is at least one common name
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
