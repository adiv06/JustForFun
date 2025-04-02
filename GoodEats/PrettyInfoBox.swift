//
//  PrettyInfoBox.swift
//  RecipeTutorial
//
//  Created by Parineeta Padgilwar on 4/23/23.
//

import SwiftUI

struct PrettyInfoBox: View {
    
    var imageText: String
    var text: String
    var data: Int
    var dataString: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            HStack(alignment: .center) {
                
                Image(systemName: imageText)
                    .padding(.leading, 10)
                Text("\(data) \(dataString) ")
                    .bold()
            }
            Text("\(text)")
                .font(.subheadline)
                
        }
        .padding(10)
        .padding(.vertical, 10)
                    .background(Rectangle()
                        .foregroundColor(.gray)
                        .opacity(0.15)
                    .cornerRadius(10))
                    .frame(maxHeight: UIScreen.main.bounds.height/10)

    }
}

struct PrettyInfoBox_Previews: PreviewProvider {
    static var previews: some View {
        PrettyInfoBox(imageText: "clock", text: "Fat", data: 7, dataString: "mins")
    }
}
