//
//  HomeView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation

import SwiftUI

//struct HomeView: View {
//    @StateObject var viewModel = HomeViewModel()
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(viewModel.recipes) { recipe in
//                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
//                        Text(recipe.name)
//                    }
//                }
//            }
//            .navigationTitle("Recipes")
//        }
//        .onAppear {
//            viewModel.loadRecipes()
//        }
//    }
//}

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Displaying categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.categories) { category in
                                CategoryView(category: category, isSelected: viewModel.selectedCategoryIDs.contains(category.id))
                                    .onTapGesture {
                                        viewModel.toggleCategorySelection(category)
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    // Displaying recipes
                    ForEach(viewModel.filteredRecipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRowView(recipe: recipe, isFavorite: viewModel.isFavorite(recipe: recipe)) {
                                viewModel.toggleFavorite(for: recipe)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("welcome,\(authManager.username)", displayMode: .inline)
        }
        .onAppear {
            viewModel.refreshData()
        }
    }
}

struct CategoryView: View {
    var category: Category
    var isSelected: Bool // Assuming you have logic to determine if selected

    var body: some View {
        Text(category.name)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(isSelected ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(15)
    }
}

struct RecipeRowView: View {
    var recipe: Recipe
    var isFavorite: Bool
    var toggleFavorite: () -> Void
    

    var body: some View {
        HStack {
            // Assuming you have an image with the recipe name or an appropriate placeholder
            Image(systemName: "house") // Make sure this is the correct property from your Recipe model
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(recipe.name).font(.headline)
                
                HStack {
                    ForEach(recipe.categories, id: \.id) { category in
                        Text(category.name)
                            .font(.caption)
                            .padding(5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }
            
            Spacer()
            
            Button(action: toggleFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

//
//struct HomeView_Previews: PreviewProvider{
//    static var previews: some View{
//        HomeView()
//    }
//}
