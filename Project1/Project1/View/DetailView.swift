//
//  DetailView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import SwiftUI

//struct RecipeDetailView: View {
//    var recipe: Recipe
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading) {
//                if let firstIngredientImageName = recipe.ingredients.first?.ingredient.imageName,
//                   let uiImage = UIImage(named: firstIngredientImageName) {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                } else {
//                    // Fallback image or placeholder if the recipe has no ingredients or image
//                    Image("placeholder_image") // Ensure you have a placeholder image in your assets
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                }
//                
//                Text(recipe.name).font(.title)
//                Text("Description: \(recipe.description)")
//                // Continue building out the detail view...
//            }
//            .padding()
//        }
//    }
//}
//

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image(systemName: "house") // Custom view for handling the recipe image
                
                Text(recipe.name)
                    .font(.title)
                    .padding(.bottom, 2)
                
                HStack {
                    ForEach(recipe.categories, id: \.self) { category in
                        Text(category.name)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }.padding(.bottom, 2)
                
//                Button(action: {
//                    isFavorite.toggle()
//                    // Handle favorite logic here
//                }) {
//                    Image(systemName: isFavorite ? "heart.fill" : "heart")
//                        .foregroundColor(isFavorite ? .red : .gray)
//                }
                
                Text("Description: \(recipe.descriptions)")
                    .padding(.vertical, 2)
                
                // Assuming you have a mechanism to select the number of servings
                // DropdownView(servings: $selectedServings) // Custom view for dropdown
                
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.headline)
                    // List ingredients here, possibly adjusting quantities based on selectedServings
                }
                
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.headline)
                    Text(recipe.instruction)
                }.padding(.top, 2)
                
                // Edit button
//                NavigationLink(destination: LoginView()) {
//                    Text("Edit")
//                }
            }.padding()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            leading: Button("Back") {
                // Action to navigate back
            },
            trailing: NavigationLink(destination: AddEditView()) {
                Text("Edit")
            }
        )
    }
}
//
//struct RecipeDetailView_Previews: PreviewProvider{
//    static var previews: some View{
//        RecipeDetailView(recipe: <#Recipe#>)
//    }
//}


