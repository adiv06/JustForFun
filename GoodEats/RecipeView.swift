//
//  RecipeView.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 3/22/23.
//

import SwiftUI

struct RecipeView: View {
    var recipe: RecipeSearchResult
    @State var ingredientNames: [String] = []
    @State var imageWidth: Int = 0
    @State var showSheetInfo: Bool = true
    var body: some View {
            ScrollView{
                VStack{
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(height: 300)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color((.gray))]), startPoint: .top, endPoint: .bottom))
                .ignoresSafeArea(.container, edges: .top)
                    
                Spacer()

                
//                VStack(alignment: .leading,spacing: 20){
//                    
//                    VStack(){
//                        Text(recipe.title)
//                            .font(.title3)
//                            .bold()
//                            .multilineTextAlignment(.leading)
//                            .padding(.top)
//                    }
//                    
//                    Text(!recipe.summary.isEmpty ? recipe.summary : "Couldn't find a summary for this recipe :(")
//                    
//                    if !(recipe.cookingMinutes.words.isEmpty || recipe.servings.words.isEmpty || recipe.readyInMinutes.words.isEmpty){
//                        
//                        HStack(){
//                            PrettyInfoBox(imageText: "clock", text: "Cook Time", data: recipe.cookingMinutes, dataString: "min")
//                            PrettyInfoBox(imageText: "spoon", text: "Amount", data: recipe.servings, dataString: "Serv.")
//                            PrettyInfoBox(imageText: "clock", text: "Ready Minutes", data: recipe.readyInMinutes, dataString: "min")
//                            
//                        }
//                        
//                    }
//                    
//                    
//                    if !recipe.analyzedInstructions.debugDescription.isEmpty{
//                        
//                        let steps = recipe.analyzedInstructions[0]?.steps
//                        
//                        VStack(alignment: .leading, spacing: 20){
//                            Text("Ingredients")
//                                .font(.headline)
//                            
//                            //   ForEach(steps ?? [Step(number: 1, step: "Could not find any steps...")], id: \.self) { step in
//                            ForEach(steps?[0].ingredients ?? [Ingredient(id: 1, name: "Could not find any ingredients for this particular recipe...", image: "no image")]) { ingredient in
//                                
//                                Text("\(ingredient.name)")
//                            }
//                            //    }
//                            
//                            
//                        }
//                        
//                        VStack(alignment: .leading, spacing: 20){
//                            Text("Directions")
//                                .font(.headline)
//                            
//                            
//                            ForEach(steps ?? [Step(number: 1, step: "Could not find any steps...")], id: \.self) { step in
//                                HStack {
//                                    Text("\(step.number)")
//                                        .bold()
//                                        .padding(10)
//                                        .background(.black)
//                                        .foregroundColor(.white)
//                                        .cornerRadius(10)
//                                    Text("\(step.step)")
//                                }
//                            }
//                            
//                        }
//                        
//                        
//                    }
//                }.frame(maxWidth: UIScreen.main.bounds.width)
//                    .padding(.horizontal, 40)
                    
            }
                    .frame(height: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .ignoresSafeArea(.container, edges: .all)
                    

                
            //.clipShape(.rect)
        }
        .ignoresSafeArea(.container, edges: .all)
        .background(.white)
    
            
            
}
    
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: RecipeSearchResult.test[0])
    }
}
