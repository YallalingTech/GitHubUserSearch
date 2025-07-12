//
//  LoaderView.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//
import SwiftUI

struct AppLoaderView: View {
    var message: String? = nil

    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
                .scaleEffect(1.5)

            if let message = message {
                Text(message)
                    .font(.body.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding(30)
        .background(Color.black.opacity(0.8))
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
