//
//  DetailView.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let firstIngredientImageName = recipe.ingredients.first?.ingredient.imageName,
                   let uiImage = UIImage(named: firstIngredientImageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    // Fallback image or placeholder if the recipe has no ingredients or image
                    Image("placeholder_image") // Ensure you have a placeholder image in your assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Text(recipe.name).font(.title)
                Text("Description: \(recipe.description)")
                // Continue building out the detail view...
            }
            .padding()
        }
    }
}
//
//struct RecipeDetailView_Previews: PreviewProvider{
//    static var previews: some View{
//        RecipeDetailView(recipe: <#Recipe#>)
//    }
//}
