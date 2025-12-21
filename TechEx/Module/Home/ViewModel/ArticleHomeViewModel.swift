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

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkManager()) {
        self.networkService = networkService
        print("ArticlesViewModel created")
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
            self.errorMessage = networkError.localizedDescription
        }
    }
    
    deinit {
        print("ArticlesViewModel destroyed")
    }
}
