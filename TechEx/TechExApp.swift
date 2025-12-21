//
//  TechExApp.swift
//  TechEx
//
//  Created by macbook on 18/12/2025.
//

import SwiftUI

@main
struct TechExApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ArticlesListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
