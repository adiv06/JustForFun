//
//  ContentView.swift
//  GoodEats
//
//  Created by Padgilwar, Adiv on 2/26/25.
//

import SwiftUI
import AVFoundation
import UIKit



struct ContentView: View {
    @State private var path: [AppScreens] = []
    @State var settings: Bool = false
    @ObservedObject var foodLogic: FoodLogic
    @EnvironmentObject var gpt: OpenAIConnector
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
                
                
            }
            .onChange(of: foodLogic.photoList, {
                Task{
                    await gpt.sendImageToAssistant(imageData: foodLogic.photoList)
                    //Makse sure to decode data into recipe array
                }
                path.append(.recipeView)
                //Should have what i need to display, do singular recipe and then I can try having a screen that lets them modify/add things
                
            })
            
            
            .alert("Error", isPresented: $settings) {
                Button("Settings", role: .destructive) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//                                    //Remove camera if it exists
//                                    path.contains(.cameraView) ? path.remove(at: path.firstIndex(of: .cameraView) ?? path.count - 1) : nil
                }
            } message: {
                Text("Camera access required for scanning")
            }
            
            
        .navigationDestination(for: AppScreens.self) { screen in
            switch(screen){
            case .recipeView:
                MainRecipeView()
                //If I wanna go back either switch the path with a seperate button or see if i can manipulate the nav bar back button
                    .navigationBarBackButtonHidden()
            case .loadingScreen: LoadingScreen()
                    //.navigationBarBackButtonHidden()
            case .savedRecipes: Text("Nun yet")
            case .homeView: Text("Nun yet")
            case .cameraView:
                CameraCreate(photoList: $foodLogic.photoList, path: $path).ignoresSafeArea()
                    .navigationBarBackButtonHidden()
            }
            
        }
        }
    }
}

#Preview {
    ContentView(foodLogic: FoodLogic())
        .environmentObject(OpenAIConnector())
        
}
