//
//  OpenAIConnector.swift
//  QuizNote
//
//  Created by Parineeta Padgilwar on 9/14/23.
//

import Foundation
import Combine

class OpenAIConnector: ObservableObject {
    /// This URL might change in the future, so if you get an error, make sure to check the OpenAI API Reference.
    let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")
    let openAIKey = "Issa secret"
    
    /// This is what stores your messages. You can see how to use it in a SwiftUI view here:
    @Published var messageLog: [[String: String]] = [
        /// Modify this to change the personality of the assistant.
        ["role": "system", "content": "You are a friendly assistant, please answer the questions given to you thoughtfully."]
    ]

    func sendToAssistant() async {
        guard let url = openAIURL else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")
        
        let httpBody: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": messageLog
        ]
        
        do {
            let httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
            request.httpBody = httpBodyJson
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid HTTP response giving out \(response), the data contained: " + (String(data: data, encoding: .utf8) ?? "Nah"))
                return
            }
            
            if let jsonStr = String(data: data, encoding: .utf8) {
                let responseHandler = OpenAIResponseHandler()
                if let decodedResponse = responseHandler.decodeJson(jsonString: jsonStr) {
                    let message = decodedResponse.choices.first?.message.content ?? "No response"
                    logMessage(message, messageUserType: .assistant)
                }
            }
        } catch {
            print("Request failed: \(error.localizedDescription)")
            logMessage("Error: \(error.localizedDescription)", messageUserType: .assistant)
        }
    }
}


/// Don't worry about this too much. This just gets rid of errors when using messageLog in a SwiftUI List or ForEach.
extension Dictionary: Identifiable { public var id: UUID { UUID() } }
extension Array: Identifiable { public var id: UUID { UUID() } }
extension String: Identifiable { public var id: UUID { UUID() } }

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
        let task = session.dataTask(with: request as URLRequest, completionHandler:{ (data: Data?, response: URLResponse?, error: Error?) -> Void in
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
    func logMessage(_ message: String, messageUserType: MessageUserType) {
        var messageUserTypeString = ""
        switch messageUserType {
        case .user:
            messageUserTypeString = "user"
        case .assistant:
            messageUserTypeString = "assistant"
        }
        
        messageLog.append(["role": messageUserTypeString, "content": message])
    }
    
    enum MessageUserType {
        case user
        case assistant
    }
}
