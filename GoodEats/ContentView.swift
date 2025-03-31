//
//  ContentView.swift
//  GoodEats
//
//  Created by Padgilwar, Adiv on 2/26/25.
//

import SwiftUI
import AVFoundation



struct ContentView: View {
    @State private var path: [AppScreens] = []
    @State var settings: Bool = false
    @ObservedObject var foodLogic: FoodLogic
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
//                NavigationLink(value: AppScreens.recipeView) {
//                    Text("Whats up press this")
//                        .foregroundStyle(.white, .black)
//                        .padding()
//                        .background(.black)
//                        .cornerRadius(5)
//                        .shadow(color: .gray, radius: 5, x: 5, y: 10)
//                }
                
                Button {
                    // Open the camera
                    switch AVCaptureDevice.authorizationStatus(for: .video) {
                    case .authorized, .notDetermined:
                        //Appending to path and switching to cameraView
                        path.append(AppScreens.cameraView)
                    default:
                        settings = true
                    }
                    
                }label: {
                    Text("Whats up press this")
                        .foregroundStyle(.white, .black)
                        .padding()
                        .background(.black)
                        .cornerRadius(5)
                        .shadow(color: .gray, radius: 5, x: 5, y: 10)
                }
                .padding()
                
                .navigationDestination(for: AppScreens.self) { screen in
                    switch(screen){
                    case .recipeView:
                        MainRecipeView()
                    case .loadingScreen: Text("Nun yet")
                    case .savedRecipes: Text("Nun yet")
                    case .homeView: Text("Nun yet")
                    case .cameraView:
                        CameraCreate(photoList: $foodLogic.photoList)//.ignoresSafeArea()
                            .navigationBarBackButtonHidden()
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView(foodLogic: FoodLogic())
        
}
