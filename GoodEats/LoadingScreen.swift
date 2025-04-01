//
//  LoadingScreen.swift
//  GoodEats
//
//  Created by Padgilwar, Adiv on 3/31/25.
//

import SwiftUI

struct LoadingScreen: View {
    @State private var isAnimating: Bool = false
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 4)
                    .foregroundColor(Color.yellow.opacity(0.3))
                    .frame(width: 80, height: 80)
                
                Circle()
                    .trim(from: 0.0, to: 0.2)
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .foregroundColor(.yellow)
                    .frame(width: 80, height: 80)
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isAnimating)
                    .onAppear {
                        isAnimating = true
                    }
            }
            .padding(.bottom, 20)
            
            Text("Generating Recipes...")
                .font(.headline)
                .foregroundColor(.black)
                .padding(.bottom, 5)
            
            Text("Please wait while we prepare your options.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(40)
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.6))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    LoadingScreen()
}
