//
//  CachedImageLoader.swift
//  TechEx
//
//  Created by macbook on 21/12/2025.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func object(forKey key: String) -> UIImage?
    func setObject(_ obj: UIImage, forKey key: String)
}

protocol DiskCacheProtocol {
    func fileURL(for url: URL) -> URL
}

protocol NetworkSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSessionProtocol {}


@MainActor
final class CachedImageLoader: ObservableObject {

    enum LoadingStatus: Equatable {
        case idle, loading, success(UIImage), failure
    }

    @Published var status: LoadingStatus = .idle

    private let imageCache: ImageCacheProtocol
    private let diskCache: DiskCacheProtocol
    private let session: NetworkSessionProtocol

    init(
        imageCache: ImageCacheProtocol = ImageCache.shared,
        diskCache: DiskCacheProtocol = DiskCache.shared,
        session: NetworkSessionProtocol = URLSession.shared
    ) {
        self.imageCache = imageCache
        self.diskCache = diskCache
        self.session = session
    }

    func load(from url: URL) async {
        status = .loading

        if let cached = imageCache.object(forKey: url.absoluteString) {
            status = .success(cached)
            return
        }

        let diskURL = diskCache.fileURL(for: url)
        if let data = try? Data(contentsOf: diskURL),
           let cached = UIImage(data: data) {
            imageCache.setObject(cached, forKey: url.absoluteString)
            status = .success(cached)
            return
        }

        do {
            let (data, _) = try await session.data(from: url)
            guard let image = UIImage(data: data) else {
                status = .failure
                return
            }

            imageCache.setObject(image, forKey: url.absoluteString)
            try? data.write(to: diskURL)
            status = .success(image)

        } catch {
            status = .failure
        }
    }

    func cancel() {
        status = .idle
    }
}
