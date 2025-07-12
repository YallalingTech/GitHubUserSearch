//
//  Extension.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//
import SwiftUI

extension View {
    func appLoader(isPresented: Bool, message: String? = nil) -> some View {
        ZStack {
            self
                .blur(radius: isPresented ? 1 : 0) // Optional blur
            
            if isPresented {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                AppLoaderView(message: message)
                    .transition(.opacity)
                    .zIndex(1001) // Loader content
                
                Color.clear
                    .ignoresSafeArea()
                    .allowsHitTesting(true)
                    .zIndex(1002)
            }
        }
        .zIndex(isPresented ? 1000 : 0)
    }
}

