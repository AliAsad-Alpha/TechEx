//
//  ArticleListView.swift
//  TechEx
//
//  Created by macbook on 20/12/2025.
//

import SwiftUI

// MARK: - Custom Views
struct ArticleRowView: View {
    let article: ArticlesResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CachedNYTImage(article: article)
                .articleImageStyle()
                
            
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "--")
                    .appFont(style: .headline, weight: .bold)
                    .primaryTextColor()
                    .lineLimit(2)
                
                Text(article.byline ?? "--")
                    .appFont(style: .caption, weight: .regular)
                    .secondaryTextColor()
            }
        }
        .articleCardStyle() // Applying custom modifier
    }
}

// MARK: - Main List View
struct ArticlesListView: View {

    @StateObject private var viewModel = ArticlesViewModel(networkService: NetworkManager())
    @EnvironmentObject private var coordinator: HomeCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            content
                .navigationTitle("Most Popular")
                .navigationDestination(for: HomeRoute.self, destination: destination)
        }
        .task {
            Task {
                viewModel.loadArticlesTask()
            }
        }
    }
}

private extension ArticlesListView {

    @ViewBuilder
    func destination(for route: HomeRoute) -> some View {
        switch route {
        case .articleDetail(let article):
            ArticleDetailView(article: article)
                .environmentObject(coordinator)
        }
    }
}


private extension ArticlesListView {

    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            ProgressView()
                .controlSize(.large)
        } else if let error = viewModel.errorMessage {
            errorView(error)
        } else {
            articlesList
        }
    }
}

private extension ArticlesListView {

    func errorView(_ error: String) -> some View {
        VStack(spacing: 12) {
            Text(error)
                .foregroundColor(.red)

            Button("Retry") {
                Task {
                    await viewModel.loadArticles()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
    }
}

private extension ArticlesListView {

    var articlesList: some View {
        List(viewModel.articles) { article in
            NavigationLink(value: HomeRoute.articleDetail(article)) {
                ArticleRowView(article: article)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
        }
        .background(AppColors.background)
        .listStyle(.plain)
        .refreshable {
            viewModel.loadArticlesTask()
        }
    }
}
