//
//  AppColorModifiers.swift
//  TechEx
//
//  Created by macbook on 23/12/2025.
//

import SwiftUI

extension View {

    func primaryTextColor() -> some View {
        foregroundColor(AppColors.primaryText)
    }

    func secondaryTextColor() -> some View {
        foregroundColor(AppColors.secondaryText)
    }
}
