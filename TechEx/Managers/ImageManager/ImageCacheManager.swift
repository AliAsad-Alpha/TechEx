//
//  ImageCacheManager.swift
//  TechEx
//
//  Created by macbook on 21/12/2025.
//

import Foundation
import UIKit

final class ImageCache: ImageCacheProtocol {
    static let shared = ImageCache()
    
    func object(forKey key: String) -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: key) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func setObject(_ obj: UIImage, forKey key: String) {
        UserDefaults.standard.setValue(obj.pngData(), forKey: key)
    }
}
