//
//  RealRecipeModel.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 4/10/23.
//

import Foundation
import SwiftUI

struct ObjectResult: Decodable{
    let results: [RecipeSearchResult]
    let offset: Int
    let number: Int
    let totalResults: Int
}
struct RecipeSearchResult: Identifiable, Decodable{
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let preparationMinutes, cookingMinutes: Int
    let aggregateLikes, healthScore: Int?
    let creditsText, sourceName: String
    let pricePerServing: Double?
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String?
    let image: String
    let imageType, summary: String
    let cuisines, dishTypes, diets: [String]?
    //let occasions: [Any?]?
    var analyzedInstructions: [AnalyzedInstruction?]
    let spoonacularSourceURL: String?
    let license: String?
}

//MARK: Recipe Info from ID

struct RecipeInfo: Decodable, Identifiable {
    
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let preparationMinutes, cookingMinutes: Int
    let aggregateLikes, healthScore: Int?
    let creditsText, license, sourceName: String
    let pricePerServing: Double?
    var extendedIngredients: [ExtendedIngredient]?
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String?
    let image: String
    let imageType: String?
    let summary: String
    let cuisines, dishTypes, diets: [String]?
    //let occasions: [Any?]?
    var winePairing: WinePairing?
    let instructions: String?
    var analyzedInstructions: [AnalyzedInstruction]?
    let spoonacularSourceURL: String?
}


// MARK: - ExtendedIngredient
struct ExtendedIngredient:Decodable {
    let id: Int?
    let aisle, image, consistency, name: String?
    let nameClean, original, originalName: String?
    let amount: Double?
    let unit: String?
    let meta: [String]?
}

// MARK: - WinePairing
struct WinePairing: Decodable {
    let pairedWines: [String]?
    let pairingText: String?
    let productMatches: [ProductMatch]?
}

// MARK: - ProductMatch
struct ProductMatch: Decodable {
    let id: Int?
    let title, description, price: String?
    let imageURL: String?
    let averageRating, ratingCount: Int?
    let score: Double?
    let link: String?
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Decodable{
    var steps: [Step]?
}
// MARK: - Ingredient
struct Ingredient: Identifiable, Decodable, Hashable{
    let id: Int
    let name: String
    let image: String?
}
// MARK: - Step
struct Step: Decodable, Hashable {
    
    static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.step == rhs.step
    }
     
    func hash(into hasher: inout Hasher) {
        hasher.combine(step)
        hasher.combine(number)
    }
    
    let number: Int
    let step: String
    var ingredients: [Ingredient]?
}

//MARK: Search by Ingredients
struct IngredientSearchResult: Identifiable, Decodable {
    let id: Int
    let title: String
    let image: String
    let usedIngredientCount: Int
    let missedIngredientCount: Int
    let missedIngredients, usedIngredients, unusedIngredients: [IngredientInfo]?
    let likes: Int?
}

// MARK: - IngredientInfo
struct IngredientInfo: Identifiable, Decodable {
    let id: Int
    let amount: Double
    let unit: String
    let unitLong, unitShort, aisle: String?
    let name, original, originalName: String
    let meta: [String]?
    let image: String?
    let extendedName: String?
}

//MARK: Test Ingredient Results
extension IngredientSearchResult{
    static let ingredientTest: [IngredientSearchResult] = [
    IngredientSearchResult(id: 1, title: "Lots of Veggietables", image: "https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153__480.jpg", usedIngredientCount: 3, missedIngredientCount: 4, missedIngredients: nil, usedIngredients: nil, unusedIngredients: nil, likes: 3),
    IngredientSearchResult(id: 2, title: "Lots of Brownies", image: "https://cdn.pixabay.com/photo/2017/05/25/09/42/brownie-2342762__480.jpg", usedIngredientCount: 3, missedIngredientCount: 4, missedIngredients: nil, usedIngredients: nil, unusedIngredients: nil, likes: 3),
    IngredientSearchResult(id: 3, title: "Bread", image: "https://cdn.pixabay.com/photo/2017/06/30/21/49/bread-2459926__480.jpg", usedIngredientCount: 3, missedIngredientCount: 4, missedIngredients: nil, usedIngredients: nil, unusedIngredients: nil, likes: 3)
    ]
    
}

//MARK: Test Extended Recipe Info from ID
extension RecipeInfo{
    static var recipeInfoTest: [RecipeInfo] = [
        RecipeInfo(vegetarian: true, vegan: true, glutenFree: true, dairyFree: true, veryHealthy: true, cheap: true, veryPopular: true, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: nil, gaps: nil, preparationMinutes: 34, cookingMinutes: 54, aggregateLikes: 45, healthScore: 45, creditsText: "Epicurious", license: "wlmedlkemwkd", sourceName: "wlmedlkemwkd", pricePerServing: 23.54, extendedIngredients: nil, id: 1, title: "Multiple Vegetables", readyInMinutes: 23, servings: 3, sourceURL: "wlmedlkemwkd", image: "https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153__480.jpg", imageType: "jpg", summary: "Vegetables are edible parts of plants that are consumed by humans as a source of nutrition. They are typically low in calories and high in fiber, vitamins, and minerals, making them an important component of a healthy and balanced diet. Vegetables can be classified into different groups based on their edible parts, such as leaves, stems, roots, flowers, and fruits.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], winePairing: nil, instructions: nil, analyzedInstructions: nil, spoonacularSourceURL: "wlmedlkemwkd"),
        RecipeInfo(vegetarian: true, vegan: true, glutenFree: true, dairyFree: true, veryHealthy: true, cheap: true, veryPopular: true, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: nil, gaps: nil, preparationMinutes: 34, cookingMinutes: 54, aggregateLikes: 45, healthScore: 45, creditsText: "Epicurious", license: "wlmedlkemwkd", sourceName: "wlmedlkemwkd", pricePerServing: 23.54, extendedIngredients: nil, id: 2, title: "Brownie Sundae", readyInMinutes: 23, servings: 3, sourceURL: "wlmedlkemwkd", image: "https://cdn.pixabay.com/photo/2017/05/25/09/42/brownie-2342762__480.jpg", imageType: "jpg", summary: "A hot brownie sundae is a decadent dessert made by topping a warm chocolate brownie with a scoop of ice cream, whipped cream, and a drizzle of hot fudge sauce. The combination of warm, gooey brownie with cold, creamy ice cream and rich chocolate sauce creates a delicious and indulgent dessert that is sure to satisfy any sweet tooth. It's a popular dessert at restaurants and cafes, and can also be easily made at home for a special treat.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], winePairing: nil, instructions: nil, analyzedInstructions: nil, spoonacularSourceURL: "wlmedlkemwkd"),
        RecipeInfo(vegetarian: true, vegan: true, glutenFree: true, dairyFree: true, veryHealthy: true, cheap: true, veryPopular: true, sustainable: true, lowFodmap: true, weightWatcherSmartPoints: nil, gaps: nil, preparationMinutes: 34, cookingMinutes: 54, aggregateLikes: 45, healthScore: 45, creditsText: "Epicurious", license: "wlmedlkemwkd", sourceName: "wlmedlkemwkd", pricePerServing: 23.54, extendedIngredients: nil, id: 3, title: "Banannan Bread", readyInMinutes: 23, servings: 3, sourceURL: "wlmedlkemwkd", image: "https://cdn.pixabay.com/photo/2017/06/30/21/49/bread-2459926__480.jpg", imageType: ".jpg", summary: "Banana bread is a sweet and moist bread-like cake made with mashed ripe bananas, flour, sugar, eggs, and butter. It is a popular baked good that is often served as a breakfast or dessert item. Banana bread can be customized with additional ingredients like nuts, chocolate chips, or spices to add flavor and texture to the final product.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], winePairing: nil, instructions: nil, analyzedInstructions: nil, spoonacularSourceURL: "wlmedlkemwkd")
        
    ]
    
}

//MARK: Extended Ingredient Test Data
extension ExtendedIngredient{
    static var extendedIngredientTest: [ExtendedIngredient] = [
        ExtendedIngredient(id: 1, aisle: "Fruits", image: "https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153__480.jpg", consistency: "idk", name: "Food 1", nameClean: "pretty name", original: "longer string", originalName: "IDK the diff", amount: 3.0, unit: "cups", meta: nil),
        ExtendedIngredient(id: 2, aisle: "Fruits", image: "https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153__480.jpg", consistency: "idk", name: "Food 2", nameClean: "pretty name", original: "longer string", originalName: "IDK the diff", amount: 3.0, unit: "cups", meta: nil),
        ExtendedIngredient(id: 3, aisle: "Fruits", image: "https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153__480.jpg", consistency: "idk", name: "Food 3", nameClean: "pretty name", original: "longer string", originalName: "IDK the diff", amount: 3.0, unit: "cups", meta: nil)
    
    ]
}
 
//MARK: Test Recipe Results
extension RecipeSearchResult{
    static let test: [RecipeSearchResult] =
    [
        RecipeSearchResult(vegetarian: false, vegan: false, glutenFree: true, dairyFree: false, veryHealthy: false, cheap: true, veryPopular: false, sustainable: false, lowFodmap: false, weightWatcherSmartPoints: 31, gaps: "Irrelevant", preparationMinutes: 25, cookingMinutes: 35, aggregateLikes: 3, healthScore: 4, creditsText: "Epicurious", sourceName: "Test Recipes 1", pricePerServing: 0.45, id: 342, title: "Multiple Vegetables", readyInMinutes: 30, servings: 4, sourceURL: "Irrelevant", image: "https://cdn.pixabay.com/photo/2015/05/04/10/16/vegetables-752153__480.jpg", imageType: ".jpg", summary: "Vegetables are edible parts of plants that are consumed by humans as a source of nutrition. They are typically low in calories and high in fiber, vitamins, and minerals, making them an important component of a healthy and balanced diet. Vegetables can be classified into different groups based on their edible parts, such as leaves, stems, roots, flowers, and fruits.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], analyzedInstructions: [AnalyzedInstruction(steps: nil)], spoonacularSourceURL: "Irrelevant", license: "Irrelevant"),
        RecipeSearchResult(vegetarian: false, vegan: false, glutenFree: true, dairyFree: false, veryHealthy: false, cheap: true, veryPopular: false, sustainable: false, lowFodmap: false, weightWatcherSmartPoints: 31, gaps: "Irrelevant", preparationMinutes: 25, cookingMinutes: 35, aggregateLikes: 3, healthScore: 4, creditsText: "fejfoijweiofjoiwjf", sourceName: "Test Recipes 1", pricePerServing: 0.45, id: 344, title: "Chocolate Sundae", readyInMinutes: 30, servings: 4, sourceURL: "Irrelevant", image: "https://cdn.pixabay.com/photo/2017/05/25/09/42/brownie-2342762__480.jpg", imageType: ".jpg", summary: "A hot brownie sundae is a decadent dessert made by topping a warm chocolate brownie with a scoop of ice cream, whipped cream, and a drizzle of hot fudge sauce. The combination of warm, gooey brownie with cold, creamy ice cream and rich chocolate sauce creates a delicious and indulgent dessert that is sure to satisfy any sweet tooth. It's a popular dessert at restaurants and cafes, and can also be easily made at home for a special treat.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], analyzedInstructions: [AnalyzedInstruction(steps: nil)], spoonacularSourceURL: "Irrelevant", license: "Irrelevant"),
        RecipeSearchResult(vegetarian: false, vegan: false, glutenFree: true, dairyFree: false, veryHealthy: false, cheap: true, veryPopular: false, sustainable: false, lowFodmap: false, weightWatcherSmartPoints: 31, gaps: "Irrelevant", preparationMinutes: 25, cookingMinutes: 35, aggregateLikes: 3, healthScore: 4, creditsText: "fejfoijweiofjoiwjf", sourceName: "Test Recipes 1", pricePerServing: 0.45, id: 363, title: "Tomato Soup", readyInMinutes: 30, servings: 4, sourceURL: "Irrelevant", image: "https://cdn.pixabay.com/photo/2016/06/01/21/40/soup-1429793__480.jpg", imageType: ".jpg", summary: "Tomato soup is a classic soup made primarily with tomatoes, onions, and vegetable or chicken broth. It is often seasoned with herbs like basil and thyme, and may include cream or milk to add a creamy texture. Tomato soup can be served hot or cold and is commonly enjoyed as a comforting meal or a starter course in many cultures.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], analyzedInstructions: [AnalyzedInstruction(steps: nil)], spoonacularSourceURL: "Irrelevant", license: "Irrelevant"),
        RecipeSearchResult(vegetarian: false, vegan: false, glutenFree: true, dairyFree: false, veryHealthy: false, cheap: true, veryPopular: false, sustainable: false, lowFodmap: false, weightWatcherSmartPoints: 31, gaps: "Irrelevant", preparationMinutes: 25, cookingMinutes: 35, aggregateLikes: 3, healthScore: 4, creditsText: "fejfoijweiofjoiwjf", sourceName: "Test Recipes 1", pricePerServing: 0.45, id: 574, title: "Banana Bread", readyInMinutes: 30, servings: 4, sourceURL: "Irrelevant", image: "https://cdn.pixabay.com/photo/2017/06/30/21/49/bread-2459926__480.jpg", imageType: ".jpg", summary: "Banana bread is a sweet and moist bread-like cake made with mashed ripe bananas, flour, sugar, eggs, and butter. It is a popular baked good that is often served as a breakfast or dessert item. Banana bread can be customized with additional ingredients like nuts, chocolate chips, or spices to add flavor and texture to the final product.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], analyzedInstructions: [AnalyzedInstruction(steps: nil)], spoonacularSourceURL: "Irrelevant", license: "Irrelevant"),
        RecipeSearchResult(vegetarian: false, vegan: false, glutenFree: true, dairyFree: false, veryHealthy: false, cheap: true, veryPopular: false, sustainable: false, lowFodmap: false, weightWatcherSmartPoints: 31, gaps: "Irrelevant", preparationMinutes: 25, cookingMinutes: 35, aggregateLikes: 3, healthScore: 4, creditsText: "fejfoijweiofjoiwjf", sourceName: "Test Recipes 1", pricePerServing: 0.45, id: 374, title: "Macaroni and Cheese", readyInMinutes: 30, servings: 4, sourceURL: "Irrelevant", image: "https://cdn.pixabay.com/photo/2019/06/29/09/00/food-4305743__480.jpg", imageType: ".jpg", summary: "Macaroni and cheese, is a popular comfort food made from cooked macaroni pasta and a cheese sauce. The cheese sauce is typically made with a combination of butter, milk, and cheese, and can be seasoned with spices and herbs for added flavor. Mac n cheese can be served as a side dish or a main course and is often enjoyed by people of all ages.", cuisines: ["Irrelevant"], dishTypes: ["Irrelevant"], diets: ["Irrelevant"], analyzedInstructions: [AnalyzedInstruction(steps: nil)], spoonacularSourceURL: "Irrelevant", license: "Irrelevant"),
    ]
}

extension Step{
    static var testSteps: [Step] = [
        Step(number: 1, step: "Preheat the oven to 350°F (175°C) and line a baking sheet with parchment paper.", ingredients: nil),
        Step(number: 2, step: "In a mixing bowl, cream together 1/2 cup of softened butter and 1/2 cup of granulated sugar until light and fluffy.", ingredients: nil),
        Step(number: 3, step: "Beat in one egg and 1 teaspoon of vanilla extract until well combined.", ingredients: nil),
        Step(number: 4, step: "In a separate bowl, whisk together 1 and 1/4 cups of all-purpose flour, 1/2 teaspoon of baking powder, and 1/4 teaspoon of salt.", ingredients: nil),
        Step(number: 5, step: "Gradually stir the dry ingredients into the wet mixture until fully incorporated. Then, fold in 1/2 cup of chocolate chips or other desired mix-ins. Scoop dough by rounded tablespoons onto the prepared baking sheet and bake for 10-12 minutes or until golden brown. Let the cookies cool for a few minutes before transferring them to a wire rack to cool completely.", ingredients: nil)
    ]
}

extension Ingredient{
    static var testIngredients: [Ingredient] = [
    Ingredient(id: 1, name: "apple", image: "https://cdn.pixabay.com/photo/2017/09/26/13/31/apple-2788616__480.jpg"),
    Ingredient(id: 2, name: "orange", image: "https://cdn.pixabay.com/photo/2016/10/07/13/36/tangerines-1721590__480.jpg"),
    Ingredient(id: 3, name: "bread", image: "https://cdn.pixabay.com/photo/2014/07/22/09/59/bread-399286__480.jpg"),
    Ingredient(id: 4, name: "flour", image: "https://cdn.pixabay.com/photo/2016/08/09/22/23/flour-1581967__480.jpg"),
    Ingredient(id: 5, name: "eggs", image: "https://cdn.pixabay.com/photo/2022/12/18/17/47/egg-7663954__480.jpg")
    
    ]
}
