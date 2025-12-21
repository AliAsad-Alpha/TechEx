//
//  ArticleListView.swift
//  TechEx
//
//  Created by macbook on 20/12/2025.
//

import SwiftUI

struct ArticlesListView: View {
    
    @ObservedObject private var viewModel = ArticlesViewModel()
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .controlSize(.large)
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink(value: article) {
                            VStack(alignment: .leading, spacing: 20) {
                                CachedNYTImage(article: article)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                                Text(article.title ?? "--")
                                    .font(.headline)
                                Text(article.byline ?? "--")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .background(Color.clear)
                        .padding(.horizontal, 0)
                        .padding(.vertical, 10)
                    }.listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Most Popular")
            .navigationDestination(for: ArticlesResult.self) { article in
                ArticleDetailView(article: article)
            }
        }
        .task {
            await viewModel.loadArticles()
        }
        .refreshable {
            await viewModel.loadArticles()
        }
    }
}

struct CachedNYTImage: View {
    let article: ArticlesResult

    @StateObject private var loader = CachedImageLoader()
    var body: some View {
        let _ = Self._printChanges()
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .task {
            if let url = article.imageURL(quality: ImageVariantSelector.selectFormat()) {
               await loader.load(from: url)
            }
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
