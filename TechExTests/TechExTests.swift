//
//  TechExTests.swift
//  TechExTests
//
//  Created by macbook on 18/12/2025.
//

import XCTest
@testable import TechEx

@MainActor // Ensures tests run on the main thread for @Published property safety
final class ArticlesViewModelTests: XCTestCase {
    
    var viewModel: ArticlesViewModel!
    var mockService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        viewModel = ArticlesViewModel(networkService: mockService)
    }

    // TEST 1: Successful Data Fetch
    func testLoadArticles_Success() async {
        // Given
        let mockArticles = [ArticlesResult(id: 1, title: "Test Article")]
        let mockBaseModel = NYTimesBaseModel(results: mockArticles)
        mockService.resultToReturn = .success(mockBaseModel)

        // When
        await viewModel.loadArticles()

        // Then
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after completion")
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Test Article")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success")
    }

    // TEST 2: Network Failure Handling
    func testLoadArticles_Failure() async {
        // Given
        let expectedError = NetworkError.serverError(404)
        mockService.resultToReturn = .failure(expectedError)

        // When
        await viewModel.loadArticles()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.articles.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
    }

    // TEST 3: Verify Loading State Transitions

    func testLoadArticles_LoadingStateTransition() async {
        // Given
        let mockBaseModel = NYTimesBaseModel(results: [])
        mockService.resultToReturn = .success(mockBaseModel)

        // When/Then
        // Start loading and check immediately before it finishes
        let task = Task {
            await viewModel.loadArticles()
        }
        
        // Brief sleep to ensure the async method has started and hit the isLoading = true line
        try? await Task.sleep(for: .nanoseconds(5))
        
        XCTAssertTrue(viewModel.isLoading, "isLoading should be true while the task is running")
        
        await task.value // Wait for it to finish
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after the task finishes")
    }
}

