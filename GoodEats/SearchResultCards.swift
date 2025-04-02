//
//  SearchResultCards.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 4/2/23.
//

import SwiftUI

struct SearchResultCards: View {
    var recipe: RecipeSearchResult
    var body: some View {
        ZStack(alignment: .leading){
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
            
            HStack(){
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        
                        
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                
                //Spacer()
                VStack(alignment: .leading){
                    //Change this later to something relavent
                    Spacer()
                    
                    Text(recipe.title)
                        .bold()
                        .padding(6)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                    
                    Text("From \(recipe.creditsText)")
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: 50)
                .padding(.horizontal)
                Spacer()
            }
            
            
                        
        }
        .frame(height: 100)
        .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: 10)
        //.padding(5)
    }
        
}

struct SearchResultCards_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultCards(recipe: RecipeSearchResult.test[0])
    }
}
