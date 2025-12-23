//
//  MockImageProtocol.swift
//  TechExTests
//
//  Created by macbook on 24/12/2025.
//

import Foundation
import UIKit
@testable import TechEx

final class MockImageCache: ImageCacheProtocol {
    var storedImage: UIImage?

    func object(forKey key: String) -> UIImage? {
        storedImage
    }

    func setObject(_ obj: UIImage, forKey key: String) {
        storedImage = obj
    }
}

final class MockDiskCache: DiskCacheProtocol {
    let url: URL

    init(url: URL) {
        self.url = url
    }

    func fileURL(for url: URL) -> URL {
        self.url
    }
}

final class MockNetworkSession: NetworkSessionProtocol {

    var result: Result<Data, Error>!

    func data(from url: URL) async throws -> (Data, URLResponse) {
        switch result {
        case .success(let data):
            return (data, URLResponse())
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set")
        }
    }
}
