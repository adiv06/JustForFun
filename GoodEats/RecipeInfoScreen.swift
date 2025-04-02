//
//  RecipeInfoScreen.swift
//  GoodEats
//
//  Created by Padgilwar, Adiv on 4/1/25.
//

import SwiftUI

struct RecipeInfoScreen: View {
    var recipe: RecipeSearchResult
    @State var ingredientNames: [String] = []
    @State var imageWidth: Int = 0
    var body: some View {
        
        VStack(alignment: .leading,spacing: 20){
            
            VStack(){
                Text(recipe.title)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding(.top)
            }
            
            Text(!recipe.summary.isEmpty ? recipe.summary : "Couldn't find a summary for this recipe :(")
            
            if !(recipe.cookingMinutes.words.isEmpty || recipe.servings.words.isEmpty || recipe.readyInMinutes.words.isEmpty){
                
                HStack(){
                    PrettyInfoBox(imageText: "clock", text: "Cook Time", data: recipe.cookingMinutes, dataString: "min")
                    PrettyInfoBox(imageText: "spoon", text: "Amount", data: recipe.servings, dataString: "Serv.")
                    PrettyInfoBox(imageText: "clock", text: "Ready Minutes", data: recipe.readyInMinutes, dataString: "min")
                    
                }
                
            }
            
            
            if !recipe.analyzedInstructions.debugDescription.isEmpty{
                
                let steps = recipe.analyzedInstructions[0]?.steps
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Ingredients")
                        .font(.headline)
                    
                    //   ForEach(steps ?? [Step(number: 1, step: "Could not find any steps...")], id: \.self) { step in
                    ForEach(steps?[0].ingredients ?? [Ingredient(id: 1, name: "Could not find any ingredients for this particular recipe...", image: "no image")]) { ingredient in
                        
                        Text("\(ingredient.name)")
                    }
                    //    }
                    
                    
                }
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Directions")
                        .font(.headline)
                    
                    
                    ForEach(steps ?? [Step(number: 1, step: "Could not find any steps...")], id: \.self) { step in
                        HStack {
                            Text("\(step.number)")
                                .bold()
                                .padding(10)
                                .background(.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                            Text("\(step.step)")
                        }
                    }
                    
                }
                
                
            }
        }.frame(maxWidth: UIScreen.main.bounds.width)
            .padding(.horizontal, 40)

    }
}

#Preview {
    RecipeInfoScreen(recipe: RecipeSearchResult.test[0])
}
