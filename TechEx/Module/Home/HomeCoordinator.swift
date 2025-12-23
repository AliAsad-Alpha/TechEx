//
//  HomeCoordinator.swift
//  TechEx
//
//  Created by macbook on 21/12/2025.
//

import Foundation
import SwiftUI

enum HomeRoute: Hashable { // Hasable is required for un
    case articleDetail(ArticlesResult)
}

class HomeCoordinator: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    
    func showArticle(_ article: ArticlesResult) {
        navigationPath.append(HomeRoute.articleDetail(article))
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count - 1)
    }
}
