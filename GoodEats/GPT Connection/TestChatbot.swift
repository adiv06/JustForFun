//
//  TestChatbot.swift
//  QuizNote
//
//  Created by Parineeta Padgilwar on 9/14/23.
//

import SwiftUI

struct TestChatbot: View {
    @State var text: String = ""
    @EnvironmentObject var gpt: OpenAIConnector
    @State var isLoading: Bool = false
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(gpt.messageLog) { message in
                        Text(message["content"] ?? "Error retrieving message")
                            .foregroundColor(.white)
                            .padding()
                            .background(message["role"] == "user" ? .blue : .black)
                            .cornerRadius(10)
                            .padding(.vertical, 25)
                    }
                }
                HStack {
                    TextField("Ask a Question..", text: $text)
                    Button {
                        guard !isLoading else { return }
                        gpt.messageLog.append(["role": "user", "content": text])
                        text = ""
                        isLoading = true
                        Task {
                            await gpt.sendToAssistant()
                            isLoading = false
                        }
                    } label: {
                        Image(systemName: "paperplane")
                    }
                    .disabled(isLoading)
                }
                .padding(25)
            }
            if isLoading {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
            }
        }
    }
}

struct TestChatbot_Previews: PreviewProvider {
    static var previews: some View {
        TestChatbot().environmentObject(OpenAIConnector())
    }
}
