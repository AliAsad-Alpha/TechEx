//
//  AppFonts.swift
//  TechEx
//
//  Created by macbook on 23/12/2025.
//

import SwiftUI

enum FontWeight {
    case regular
    case semibold
    case bold

    var fontName: String {
        switch self {
        case .regular: return AppTypography.regular
        case .semibold: return AppTypography.semibold
        case .bold: return AppTypography.bold
        }
    }
}

enum AppTypography {

    // Font family
    static let regular = "Poppins-Regular"
    static let semibold = "Poppins-SemiBold"
    static let bold = "Poppins-Bold"

    // Semantic font styles
    static func font(
        style: Font.TextStyle,
        weight: FontWeight = .regular
    ) -> Font {
        Font.custom(
            weight.fontName,
            size: baseSize(for: style),
            relativeTo: style
        )
    }

    private static func baseSize(for style: Font.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle: return 34
        case .title: return 28
        case .headline: return 17
        case .body: return 17
        case .caption: return 12
        default: return 17
        }
    }
}

