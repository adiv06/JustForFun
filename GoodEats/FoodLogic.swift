//
//  FoodLogic.swift
//  GoodEats
//
//  Created by Padgilwar, Adiv on 3/31/25.
//

import Foundation
import SwiftUI

class FoodLogic: ObservableObject{
    @Published var savedRecipes: [RecipeInfo]
    @Published var photoList: [UIImage]
    
    init(){
        savedRecipes = []
        photoList = []
    }
    
    
}
