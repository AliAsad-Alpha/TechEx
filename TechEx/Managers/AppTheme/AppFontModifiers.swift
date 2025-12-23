//
//  AppFontModifiers.swift
//  TechEx
//
//  Created by macbook on 23/12/2025.
//

import SwiftUI

struct AppFontModifier: ViewModifier {

    let style: Font.TextStyle
    let weight: FontWeight

    func body(content: Content) -> some View {
        content
            .font(AppTypography.font(style: style, weight: weight))
            .lineSpacing(style == .body ? 4 : 2)
    }
}

extension View {

    func appFont(
        style: Font.TextStyle,
        weight: FontWeight = .regular
    ) -> some View {
        modifier(AppFontModifier(style: style, weight: weight))
    }
}


