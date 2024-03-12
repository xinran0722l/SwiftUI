//
//  DataService.swift
//  Project1
//
//  Created by Xinran Yu on 3/10/24.
//

import Foundation
import CoreData


enum TableName: String{
    
    case recipe = "RecipeObject"
    case collect = "CollectObject"
    
}

class DataService {
    // Singleton instance for simplicity
    static let shared = DataService()
    private var categories: [Category] = []
    
    private init() {
        categories = fetchCategories()
        context = persistentContainer.newBackgroundContext()
    }
    
    @MainActor
    func initExampleData() async{
        if (UserDefaults.standard.bool(forKey: "init_example_data")){
            return
        }
        let bRecipe = Recipe(name: "Pancakes", isFavorite: false, descriptions: "Delicious breakfast pancakes.", instruction: "Mix and cook.", categories: [Category(id:UUID(), name: "Breakfast")], ingredients: [
            RecipeIngredient(ingredient: Ingredient(name: "Source 1", imageName: "", unit: "g"), quantity: "200")
        ])
        let vRecipe = Recipe(name: "Vegetarian Pizza", isFavorite: false, descriptions: "A tasty vegetarian pizza.", instruction: "Prepare dough, add toppings, and bake.", categories: [Category(id:UUID(), name: "Vegetarian")], ingredients: [
            RecipeIngredient(ingredient: Ingredient(name: "Source 2", imageName: "", unit: "kg"), quantity: "1")
        ])
        await insertOrReplaceRecipe([bRecipe, vRecipe])
        UserDefaults.standard.setValue(true, forKey: "init_example_data")
        UserDefaults.standard.synchronize()
    }

    func fetchCategories() -> [Category] {
        // Simulate fetching categories
        return [
            Category(id:UUID(), name: "Breakfast"),
            Category(id:UUID(), name: "Vegetarian"),
            // Add more categories as needed
        ]
    }

//    func fetchRecipes() -> [Recipe] {
//        // Simulate fetching recipes
//        let breakfastCategory = categories.first { $0.name == "Breakfast" }
//        let vegetarianCategory = categories.first { $0.name == "Vegetarian" }
//
//        return [
//            Recipe(name: "Pancakes", isFavorite: false, descriptions: "Delicious breakfast pancakes.", instruction: "Mix and cook.", categories: breakfastCategory != nil ? [breakfastCategory!] : [], ingredients: []),
//            Recipe(name: "Vegetarian Pizza", isFavorite: false, descriptions: "A tasty vegetarian pizza.", instruction: "Prepare dough, add toppings, and bake.", categories: vegetarianCategory != nil ? [vegetarianCategory!] : [], ingredients: [])
//            // Add more recipes as needed
//        ]
//    }
    
    //MARK: - Recipe
    
    /// Insert or replace
    @MainActor
    func insertOrReplaceRecipe(_ rs: [Recipe]) async -> Bool{
        var status = false
        await context.perform {
            let identifiers = rs.map { $0.name }
            // batch fetch
            let fetchRequest = NSFetchRequest<RecipeObject>(entityName: TableName.recipe.rawValue)
            fetchRequest.predicate = NSPredicate(format: "name IN %@", identifiers)
            do {
                let existingRecipes = try self.context.fetch(fetchRequest)
                let lookup = Dictionary(uniqueKeysWithValues: existingRecipes.map { ($0.name, $0) })
                // handle bed
                for recipe in rs {
                    let id = recipe.name
                    /// If exist ignore
                    if let existingRecipe = lookup[id] {
                        existingRecipe.name = recipe.name
                        existingRecipe.instruction = recipe.instruction
                        var categories = [[String:Any]]()
                        recipe.categories.forEach { category in
                            if let jsonString = category.toJson(){
                                categories.append(jsonString)
                            }
                        }
                        existingRecipe.categories = self.tryJsonEncode(categories)
                        existingRecipe.desc = recipe.descriptions
                        var ingredients = [[String:Any]]()
                        recipe.ingredients.forEach { ingredient in
                            if let jsonString = ingredient.toJson(){
                                ingredients.append(jsonString)
                            }
                        }
                        existingRecipe.ingredients = self.tryJsonEncode(ingredients)
                    } else {
                        // insert new record
                        let recipeEntity = NSEntityDescription.insertNewObject(forEntityName: TableName.recipe.rawValue, into: self.context)
                        recipeEntity.setValue(recipe.name, forKey: "name")
                        recipeEntity.setValue(recipe.descriptions, forKey: "desc")
                        recipeEntity.setValue(recipe.instruction, forKey: "instruction")
                        recipeEntity.setValue(self.tryJsonEncode(recipe.categories.map({ $0.toJson()})), forKey: "categories")
                        recipeEntity.setValue(self.tryJsonEncode(recipe.ingredients.map({ $0.toJson()})), forKey: "ingredients")
                    }
                }
            } catch let error as NSError {
                print("Error: \(error), \(error.userInfo)")
            }
            
            do {
                if self.context.hasChanges {
                    try self.context.save()
                    status = true
                }
            } catch let error as NSError {
                print("\(self.context) Could not save \(error), \(error.userInfo)")
            }
        }
        return status
    }
    
    @MainActor
    func getAllRecipes() async -> [Recipe] {
        let collectedRecipes = await getAllCollectedRecipes().map { $0.recipe }
        let fetchRequest = NSFetchRequest<RecipeObject>(entityName: TableName.recipe.rawValue)
        var recipes: Array<Recipe> = []
        self.context.performAndWait {
            do {
                let results: [RecipeObject] = try self.context.fetch(fetchRequest)
                results.forEach { e in
                    var rpMap = convertToJsonObject(managedObject: e)
                    let categories = rpMap["categories"] as? String ?? ""
                    rpMap["categories"] = tryJsonDecode(categories)
                    let ingredients = rpMap["ingredients"] as? String ?? ""
                    rpMap["ingredients"] = tryJsonDecode(ingredients)
                    let rp: Recipe? = Recipe.fromJson(jsonObject: rpMap)
                    if var recipe = rp {
                        recipe.isFavorite = collectedRecipes.contains(recipe.name)
                        recipes.append(recipe)
                    }
                }
            } catch{
                print("fetchAllRecipesFromLocale error: \(error)")
            }
        }
        return recipes
    }
    
    @MainActor
    func deleteRecipe(_ recipeNames: [String]) async{
        let fetchRequest = NSFetchRequest<RecipeObject>(entityName: TableName.recipe.rawValue)
        self.context.performAndWait {
            do {
                let results: [RecipeObject] = try self.context.fetch(fetchRequest)
                for result in results {
                    self.context.delete(result)
                }
            } catch{
                print("Delete recipe error: \(error)")
            }
            do {
                if self.context.hasChanges {
                    try self.context.save()
                }
            } catch let error as NSError {
                print("\(self.context) Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    //MARK: - Collect
    func getAllCollectedRecipes() async -> [RecipeCollect] {
        let fetchRequest = NSFetchRequest<CollectObject>(entityName: TableName.collect.rawValue)
        fetchRequest.predicate = NSPredicate(format: "status == %@", true as NSNumber)
        var recipes: Array<RecipeCollect> = []
        self.context.performAndWait {
            do {
                let results: [CollectObject] = try self.context.fetch(fetchRequest)
                results.forEach { e in
                    var rpMap = convertToJsonObject(managedObject: e)
                    let rp: RecipeCollect? = RecipeCollect.fromJson(jsonObject: rpMap)
                    if let recipe = rp {
                        recipes.append(recipe)
                    }
                }
            } catch{
                print("getAllCollectedRecipes error: \(error)")
            }
        }
        return recipes
    }
    
    @MainActor
    func updateRecipeCollectStatus(recipeName: String, status: Bool) async{
        await context.perform {
            // batch fetch
            let fetchRequest = NSFetchRequest<CollectObject>(entityName: TableName.collect.rawValue)
            fetchRequest.predicate = NSPredicate(format: "recipe == %@ AND userId == %@", recipeName, AuthManager.shared.username)
            do {
                let existingRecipes = try self.context.fetch(fetchRequest)
                if existingRecipes.isEmpty{
                    let recipeEntity = NSEntityDescription.insertNewObject(forEntityName: TableName.collect.rawValue, into: self.context)
                    recipeEntity.setValue(recipeName, forKey: "recipe")
                    recipeEntity.setValue(Int(Date.now.timeIntervalSince1970), forKey: "updateTime")
                    recipeEntity.setValue(AuthManager.shared.username, forKey: "userId")
                    recipeEntity.setValue(status, forKey: "status")
                } else {
                    let existingRecipe = existingRecipes.first
                    existingRecipe?.recipe = recipeName
                    existingRecipe?.userId = AuthManager.shared.username
                    existingRecipe?.status = status
                    existingRecipe?.updateTime = Int64(Date.now.timeIntervalSince1970)
                }
            } catch let error as NSError {
                print("Error: \(error), \(error.userInfo)")
            }
            
            do {
                if self.context.hasChanges {
                    try self.context.save()
                }
            } catch let error as NSError {
                print("\(self.context) Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    //MARK: - Core Data
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Recipe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// Current context
    var context: NSManagedObjectContext!
//    {
//        return persistentContainer.newBackgroundContext()
//    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Utils
    
    func tryJsonEncode(_ object: Any) -> String? {
        if let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } else {
            print("Failed to convert json to string")
            return nil
        }
    }
    
    func tryJsonDecode<T>(_ json: String) -> T?{
        if let data = json.data(using: .utf8), let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            return jsonData as? T
        } else {
            print("Failed to convert dictionary to data")
            return nil
        }
    }
    
    func convertToJsonObject(managedObject: NSManagedObject) -> [String: Any] {
        var json = [String: Any]()
        for attribute in managedObject.entity.attributesByName {
            if let value = managedObject.value(forKey: attribute.key) {
                json[attribute.key] = value
            }
        }
        return json
    }
    
}

