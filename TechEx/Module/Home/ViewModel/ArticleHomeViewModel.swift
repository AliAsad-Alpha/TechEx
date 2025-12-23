//
//  ArticleHomeViewModel.swift
//  TechEx
//
//  Created by macbook on 20/12/2025.
//

import Foundation

final class ArticlesViewModel: ObservableObject {

    @Published var articles: [ArticlesResult] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var activeTask: Task<Void, Never>?
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        print("ArticlesViewModel created")
    }

    @MainActor
    func loadArticlesTask() {
        // Cancel any previous task if this is a fresh manual reload
        activeTask?.cancel()
        
        activeTask = Task {
            await loadArticles()
        }
    }
    
    @MainActor
    func loadArticles() async {
        isLoading = true
        errorMessage = nil
        
        let result = await networkService.sendRequest(request: ArticleEndpoint())
    
        self.isLoading = false
        switch result {
        case .success(let success):
            self.articles = success.results
        case .failure(let networkError):
            // Check specifically for cancelled error to avoid showing error UI
            if (networkError as? URLError)?.code == .cancelled { return }
            self.errorMessage = networkError.localizedDescription
        }
    }
    
    deinit {
        print("ArticlesViewModel destroyed")
    }
}
