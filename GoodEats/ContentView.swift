//
//  ContentView.swift
//  GoodEats
//
//  Created by Padgilwar, Adiv on 2/26/25.
//

import SwiftUI



struct ContentView: View {
    @State private var path: [AppScreens] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                NavigationLink(value: AppScreens.recipeView) {
                    Text("Whats up press this")
                        .foregroundStyle(.white, .black)
                        .padding()
                        .background(.black)
                        .cornerRadius(5)
                        .shadow(color: .gray, radius: 5, x: 5, y: 10)
                }
                
                
            }
            .padding()
            
            .navigationDestination(for: AppScreens.self) { screen in
                switch(screen){
                case .recipeView:
                    MainRecipeView()
                case .loadingScreen: Text("Nun yet")
                case .savedRecipes: Text("Nun yet")
                case .homeView: Text("Nun yet")
                }

            }
        }
    }
}

#Preview {
    ContentView()
}
