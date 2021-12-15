//
//  SpoonacularClient.swift
//  WishListApp
//
//  Created by Ольга Горбачева on 20.11.21.
//

import UIKit

// паттерн строитель

class SpoonacularClient {
    static let apiKey = "ca39229001a84773943040b19bbf53ed"
    static let host = "api.spoonacular.com"
    static let scheme = "https"
    
    static var randomRecipeURL: URL {
        var components = URLComponents()
        components.host = host
        components.path = "/recipes/random"
        components.scheme = scheme
        
        components.queryItems = [URLQueryItem]()
        components.queryItems?.append(URLQueryItem(name: "apiKey", value: SpoonacularClient.apiKey))
        components.queryItems?.append(URLQueryItem(name: "number", value: "3"))
        
        return components.url!
    }
    
    private class func configureRecipe(recipeInfo: [String: Any]) -> Recipe{
        var recipe = Recipe()
        
        if let title = recipeInfo["title"] as? String {
            recipe.title = title
        }
        
        if let servings = recipeInfo["servings"] as? Int {
            recipe.servings = servings
        }
        
        if let imageURL = recipeInfo["image"] as? String {
            recipe.imageURL = imageURL
        }
        
        if let sourceURL = recipeInfo["sourceUrl"] as? String {
            recipe.sourceURL = sourceURL
        }

        if let ingredientArray = recipeInfo["extendedIngredients"] as? [[String: Any]] {
            if ingredientArray.count == 0 {
                recipe.ingredients = []
            } else {
                var ingredients = [String]()
                for ingredient in ingredientArray {
                    if let ingredient = ingredient["originalString"] as? String {
                        ingredients.append(ingredient)
                    }
                }
                recipe.ingredients = ingredients
            }
        } else {
            recipe.ingredients = []
        }
        
        if let timeRequired = recipeInfo["readyInMinutes"] as? Int {
            recipe.timeRequired = timeRequired
        }
        
        if let instructions = recipeInfo["analyzedInstructions"] as? [[String : Any]]  {
            if instructions.count == 0 {
                recipe.instructions = []
            } else {
                var instructionsArray = [String]()
                for instructionSteps in instructions {
                    if let instructionSteps = instructionSteps["steps"] as? [[String : Any]] {
                        for step in instructionSteps {
                            if let instructionStep = step["step"] as? String {
                                instructionsArray.append(instructionStep)
                            }
                        }
                    }
                }
                recipe.instructions = instructionsArray
            }
        } else {
            recipe.instructions = []
        }
        return recipe
    }
    
    private class func createRecipes(recipeArray: [[String: Any]]) -> [Recipe] {
        var recipes = [Recipe]()
        for recipeInfo in recipeArray {
            let recipe = configureRecipe(recipeInfo: recipeInfo)
            recipes.append(recipe)
        }
        return recipes
    }
    // делаем запрос
    class func getRandomRecipe(completion: @escaping ([Recipe], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: SpoonacularClient.randomRecipeURL) { (data, response, error) in
            if error != nil {
                completion([], error)
                return
            }
            guard let data = data else {
                completion([], error)
                return
            }
            do {
                let responseObject = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [AnyHashable: Any]
                if let recipeArray = responseObject?["recipes"] as? [[String: Any]] {
                    let recipes = createRecipes(recipeArray: recipeArray)
                    completion(recipes, nil)
                }
                else {
                    completion([], error)
                }
            } catch {
                completion([], error)
            }
        }
        task.resume() // запускаем задачу
    }
    
    class func downloadRecipeImage(imageURL: String, completion: @escaping (UIImage?, Bool) -> Void) {
        if let url = URL(string: imageURL) {
            DispatchQueue.global(qos: .userInitiated).async {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else {
                        completion(nil, false)
                        return
                    }
                    DispatchQueue.main.async{
                        completion(UIImage(data: data), true)
                    }
                }
                task.resume()
            }
        }
    }
}
 









