//
//  HomeView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text(recipe.name)
                    }
                }
            }
            .navigationTitle("Recipes")
        }
        .onAppear {
            viewModel.loadRecipes()
        }
    }
}

struct HomeView_Previews: PreviewProvider{
    static var previews: some View{
        HomeView()
    }
}
