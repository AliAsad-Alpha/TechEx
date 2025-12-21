//
//  ArticleDetailView.swift
//  TechEx
//
//  Created by macbook on 20/12/2025.
//

import SwiftUI

struct ArticleDetailView: View {

    let article: ArticlesResult

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                CachedNYTImage(article: article)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                Text(article.title ?? "--")
                    .font(.title)
                    .bold()

                Text(article.byline ?? "--")
                    .foregroundColor(.secondary)

                Text(article.abstract ?? "--")
                    .font(.body)
                Text(article.adx_keywords ?? "--")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
