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
//    @Published var favoriteRecipeIDs: Set<UUID> = []
    @Published var selectedCategoryIDs: Set<UUID> = []

    init() {
        categories = DataService.shared.fetchCategories()
    }
    
    @MainActor
    func refreshData() async{
        recipes = await DataService.shared.getAllRecipes()
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
        let statusAfterChanged = !recipe.isFavorite
        Task{
            await DataService.shared.updateRecipeCollectStatus(recipeName:recipe.name, status:statusAfterChanged)
            await refreshData()
        }
    }
//    func isFavorite(recipe: Recipe) -> Bool {
//        favoriteRecipeIDs.contains(recipe.id)
//    }

}

