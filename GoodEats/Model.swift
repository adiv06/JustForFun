//
//  Model.swift
//  GoodEats
//
//  Created by Padgilwar, Adiv on 2/26/25.
//

import Foundation
import UIKit

//class RecipeModel{
//    
//}

//Outside of class, keeping things efficient this time!!!
enum AppScreens {
    case recipeView
    case loadingScreen
    case savedRecipes
    case homeView
    case cameraView
}


extension UIImage {
    /// Converts the UIImage to a base64-encoded string.
    /// - Parameter compressionQuality: The quality of the compressed image (0.0 to 1.0). Applies only if the image is converted to JPEG format.
    /// - Returns: A base64-encoded string representing the image, or nil if the conversion fails.
    func toBase64(compressionQuality: CGFloat = 1.0) -> String? {
        // Attempt to convert the image to JPEG data with the specified compression quality
        if let jpegData = self.jpegData(compressionQuality: compressionQuality) {
            return jpegData.base64EncodedString()
        }
        // If JPEG conversion fails, attempt to convert to PNG data
        if let pngData = self.pngData() {
            return pngData.base64EncodedString()
        }
        // Return nil if both conversions fail
        return nil
    }
}

