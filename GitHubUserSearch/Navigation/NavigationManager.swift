//
//  NavigationManager.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 12/07/25.
//

import Foundation
import SwiftUI

final class NavigationManager: ObservableObject {
    public static let shared = NavigationManager()
    @Published var navigationPath = NavigationPath()
    
    func pushView(_ destination: NavigationDestination) {
        navigationPath.append(destination)
    }
    
    func popView() {
        if navigationPath.count > 0 {
            navigationPath.removeLast()
        }
    }
    
    func popToRoot() {
        navigationPath = NavigationPath()
    }
}

enum NavigationDestination {
    case userSearch
//    case userDetail(User)
}
