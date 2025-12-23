//
//  ArticleViewModifiers.swift
//  TechEx
//
//  Created by macbook on 23/12/2025.
//

import SwiftUI

// MARK: - Custom View Modifiers
struct ArticleCardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

extension View {
    func articleCardStyle() -> some View {
        modifier(ArticleCardModifier())
    }
}

struct ArticleImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func articleImageStyle() -> some View {
        modifier(ArticleImageModifier())
    }
}
