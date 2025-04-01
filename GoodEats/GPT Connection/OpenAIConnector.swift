//
//  OpenAIConnector.swift
//  QuizNote
//
//  Created by Parineeta Padgilwar on 9/14/23.
//

import Foundation
import Combine
import UIKit

class OpenAIConnector: ObservableObject {
    /// This URL might change in the future, so if you get an error, make sure to check the OpenAI API Reference.
    let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")
    //Whenever I push keep this a secret...
    let openAIKey = "who knows?"
    
    /// This is what stores your messages. You can see how to use it in a SwiftUI view here:
    @Published var messageLog: [ChatMessage] = []

    struct ChatMessage: Identifiable {
        let id = UUID()
        let role: String
        let content: String
    }

    func sendImageToAssistant(imageData: [UIImage]) async {
        guard let url = openAIURL else {
            print("Invalid URL")
            return
        }
        
        //let base64Image = imageData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        
        // Ensure we append the base64 image properly to the messages
        var messageLogWithImage = messageLog
        
        for image in imageData{
            let base64Image = image.toBase64() ?? "Could not process image"
            let imageMessage = ChatMessage(role: "user", content: base64Image)
            messageLogWithImage.append(imageMessage)
            
        }
        
        
        let httpBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": messageLogWithImage
        ]
        
        do {
            let httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
            request.httpBody = httpBodyJson
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid response")
                return
            }
            
            if let jsonStr = String(data: data, encoding: .utf8) {
                let responseHandler = OpenAIResponseHandler()
                if let decodedResponse = responseHandler.decodeJson(jsonString: jsonStr) {
                    let message = decodedResponse.choices.first?.message.content ?? "No response"
                    await MainActor.run {
                        logMessage(message, messageUserType: .assistant)
                    }
                }
            }
        } catch {
            print("Request failed: \(error.localizedDescription)")
        }
    }

    
    
}


/// Don't worry about this too much. This just gets rid of errors when using messageLog in a SwiftUI List or ForEach.
extension Dictionary: @retroactive Identifiable { public var id: UUID { UUID() } }
extension Array: @retroactive Identifiable { public var id: UUID { UUID() } }
extension String: @retroactive Identifiable { public var id: UUID { UUID() } }

/// DO NOT TOUCH THIS. LEAVE IT ALONE.
extension OpenAIConnector {
    private func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        let session: URLSession
        if (sessionConfig != nil) {
            session = URLSession(configuration: sessionConfig!)
        } else {
            session = URLSession.shared
        }
        var requestData: Data?
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                print("error: \(error!.localizedDescription): \(error!.localizedDescription)")
            } else if data != nil {
                requestData = data
            }
            
            print("Semaphore signalled")
            semaphore.signal()
        })
        task.resume()
        
        // Handle async with semaphores. Max wait of 10 seconds
        let timeout = DispatchTime.now() + .seconds(30)
        print("Waiting for semaphore signal")
        let retVal = semaphore.wait(timeout: timeout)
        print("Done waiting, obtained - \(retVal)")
        return requestData
    }
}

extension OpenAIConnector {
    /// This function makes it simpler to append items to messageLog.
    // Update to accept either text or image data
    func logMessage(_ message: String, messageUserType: MessageUserType) {
        let newMessage = ChatMessage(role: messageUserType == .user ? "user" : "assistant", content: message)
        messageLog.append(newMessage)
    }

    func logMessage(_ imageData: Data, messageUserType: MessageUserType) {
        let base64Image = imageData.base64EncodedString()
        let newMessage = ChatMessage(role: messageUserType == .user ? "user" : "assistant", content: base64Image)
        messageLog.append(newMessage)
    }
    
    enum MessageUserType {
        case user
        case assistant
    }
}
