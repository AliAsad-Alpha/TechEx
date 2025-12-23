//
//  CachedImage.swift
//  TechEx
//
//  Created by macbook on 23/12/2025.
//

import SwiftUI

struct CachedNYTImage: View {
    let article: ArticlesResult
    
    @StateObject private var loader = CachedImageLoader()
    var body: some View {
        Group {
            switch loader.status {
            case .idle, .loading:
                ProgressView() // Show loading indicator
            case .success(let uiImage):
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            case .failure:
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Failed to load")
                }
                .foregroundColor(.red)
            }
        }
        .task {
            if let url = article.imageURL(quality: ImageVariantSelector.selectFormat()) {
               await loader.load(from: url)
            }
        }
    }
}
