//
//  ImageCacheManager.swift
//  TechEx
//
//  Created by macbook on 21/12/2025.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}
