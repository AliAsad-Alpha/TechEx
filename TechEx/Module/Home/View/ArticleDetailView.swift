//
//  ArticleDetailView.swift
//  TechEx
//
//  Created by macbook on 20/12/2025.
//

import SwiftUI

struct ArticleDetailView: View {

    let article: ArticlesResult
    @EnvironmentObject private var coordinator: HomeCoordinator
    @State private var showBackConfirmation = false

    var body: some View {
        ScrollView {
            content
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            backButton
        }
        .alert(
            "Go back?",
            isPresented: $showBackConfirmation,
            actions: alertActions
        )
    }
}

private extension ArticleDetailView {

    var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerImage
            titleSection
            metaSection
            bodySection
        }
        .padding()
    }
}

private extension ArticleDetailView {

    var headerImage: some View {
        CachedNYTImage(article: article)
            .articleImageStyle()
    }
}

private extension ArticleDetailView {

    var titleSection: some View {
        Text(article.title ?? "—")
            .appFont(style: .title)
            .bold()
    }
}

private extension ArticleDetailView {

    var metaSection: some View {
        Text(article.byline ?? "")
            .foregroundColor(.secondary)
    }
}

private extension ArticleDetailView {

    var bodySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(article.abstract ?? "")
                .appFont(style: .body)

            if let keywords = article.adx_keywords, !keywords.isEmpty {
                Text(keywords)
                    .appFont(style: .footnote)
                    .foregroundColor(.secondary)
            }
        }
    }
}

private extension ArticleDetailView {

    var backButton: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showBackConfirmation = true
            } label: {
                Image(systemName: "chevron.left")
            }
        }
    }
}

private extension ArticleDetailView {

    func alertActions() -> some View {
        Group {
            Button("Yes", role: .destructive) {
                coordinator.pop()
            }
            Button("Cancel", role: .cancel) { }
        }
    }
}

