//
//  ImageCacheTests.swift
//  TechExTests
//
//  Created by macbook on 24/12/2025.
//

import XCTest
@testable import TechEx

@MainActor
final class ImageCacheTests: XCTestCase {

    override func setUpWithError() throws {
        test_initialState_isIdle()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_initialState_isIdle() {
        let loader = CachedImageLoader(
            imageCache: MockImageCache(),
            diskCache: MockDiskCache(url: FileManager.default.temporaryDirectory),
            session: MockNetworkSession()
        )

        XCTAssertEqual(loader.status, .idle)
    }
    
    func test_load_returnsImageFromMemoryCache() async {
        let image = UIImage(systemName: "star")!
        let imageCache = MockImageCache()
        imageCache.storedImage = image

        let loader = CachedImageLoader(
            imageCache: imageCache,
            diskCache: MockDiskCache(url: FileManager.default.temporaryDirectory),
            session: MockNetworkSession()
        )

        await loader.load(from: URL(string: "https://test.com/image")!)

        if case .success(let result) = loader.status {
            XCTAssertEqual(result.pngData(), image.pngData())
        } else {
            XCTFail("Expected success")
        }
    }

    func test_load_downloadsImageSuccessfully() async {
        let image = UIImage(systemName: "star")!
        let data = image.pngData()!

        let session = MockNetworkSession()
        session.result = .success(data)

        let loader = CachedImageLoader(
            imageCache: MockImageCache(),
            diskCache: MockDiskCache(url: FileManager.default.temporaryDirectory.appendingPathComponent("img")),
            session: session
        )

        await loader.load(from: URL(string: "https://test.com/image")!)

        if case .success = loader.status {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected success")
        }
    }

    func test_load_networkFailure_setsFailureState() async {
        let session = MockNetworkSession()
        session.result = .failure(URLError(.badServerResponse))

        let loader = CachedImageLoader(
            imageCache: MockImageCache(),
            diskCache: MockDiskCache(url: FileManager.default.temporaryDirectory),
            session: session
        )

        await loader.load(from: URL(string: "https://test.com/image")!)

        XCTAssertEqual(loader.status, .failure)
    }

    func test_cancel_setsIdleState() {
        let loader = CachedImageLoader(
            imageCache: MockImageCache(),
            diskCache: MockDiskCache(url: FileManager.default.temporaryDirectory),
            session: MockNetworkSession()
        )

        loader.cancel()

        XCTAssertEqual(loader.status, .idle)
    }

}
