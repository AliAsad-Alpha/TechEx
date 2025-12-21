//
//  CachedImageLoader.swift
//  TechEx
//
//  Created by macbook on 21/12/2025.
//

import Foundation
import UIKit

@MainActor
final class CachedImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var task: Task<Void, Never>?

    func load(from url: URL) async {
        // 1. Memory cache
        task = Task {
            if let cached = ImageCache.shared.object(forKey: url as NSURL) {
                image = cached
                return
            }
            
            // 2. Disk cache
            let diskURL = DiskCache.shared.fileURL(for: url)
            if let data = try? Data(contentsOf: diskURL),
               let cached = UIImage(data: data) {
                ImageCache.shared.setObject(cached, forKey: url as NSURL)
                image = cached
                return
            }
            
            
            // 3. Download
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard !Task.isCancelled,
                      let downloaded = UIImage(data: data) else { return }
                
                ImageCache.shared.setObject(downloaded, forKey: url as NSURL)
                try? data.write(to: diskURL)
                
                DispatchQueue.main.async {
                    self.image = downloaded
                }
            } catch {
                print("Image download failed:", error)
            }
            
        }
    }

    func cancel() {
        task?.cancel()
    }
}
