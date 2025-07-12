//
//  GitHubUserSearchApp.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//

import SwiftUI

@main
struct GitHubUserSearchApp: App {
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(navigationManager)
        }
    }
}
