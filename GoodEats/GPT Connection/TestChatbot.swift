//
//  TestChatbot.swift
//  QuizNote
//
//  Created by Parineeta Padgilwar on 9/14/23.
//

import SwiftUI

import PhotosUI

struct TestChatbot: View {
    @EnvironmentObject var gpt: OpenAIConnector
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            ScrollView {
                ForEach(gpt.messageLog) { message in
                    Text(message.content)
                        .foregroundColor(.white)
                        .padding()
                        .background(message.role == "user" ? .blue : .black)
                        .cornerRadius(10)
                        .padding(.vertical, 25)
                }
            }

            PhotosPicker(selection: $selectedItem, matching: .images) {
                Label("Select Image", systemImage: "photo")
            }
            .onChange(of: selectedItem) { newItem in
                Task {
                    // Safely unwrap `newItem` before proceeding
                    if let item = newItem {
                        // Load the transferable data
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            selectedImageData = data
                            // Log the image as base64
                            gpt.logMessage(data, messageUserType: .user)
                            isLoading = true
                            await gpt.sendImageToAssistant(imageData: data)
                            isLoading = false
                        }
                    }
                }
            }


            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
        .padding()
    }
}

struct TestChatbot_Previews: PreviewProvider {
    static var previews: some View {
        TestChatbot().environmentObject(OpenAIConnector())
    }
}
