//
//  RecipeViewModel.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

//import SwiftUI
//
//class RecipeViewModel: ObservableObject {
//    @Published var recipe: Recipe
//    init(recipe: Recipe) {
//        self.recipe = recipe
//    }
//    func saveChanges() {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        
//        // Assuming 'RecipeEntity' is your Core Data entity name
//        let entity = NSEntityDescription.entity(forEntityName: "RecipeEntity", in: managedContext)!
//        
//        // If editing an existing recipe, you would fetch it instead of creating a new one
//        let recipeObject = NSManagedObject(entity: entity, insertInto: managedContext)
//        
//        // Assign values from your recipe model to the managed object
//        recipeObject.setValue(recipe.name, forKeyPath: "name")
//        recipeObject.setValue(recipe.description, forKey: "description")
//        // Continue setting other properties...
//        
//        // Handle categories and ingredients similarly, considering their relationships
//        
//        do {
//            try managedContext.save()
//            // Handle successful save, such as updating UI or popping view
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//            // Handle error, such as showing an error message
//        }
//    }
//
//}

