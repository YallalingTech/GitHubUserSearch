//
//  UserDetailView.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//
import SwiftUI
import Foundation
import Combine

struct UserDetailView: View {
    @ObservedObject var vm: GitHubViewModel

    var body: some View {
        List {
            Section(header: Text("Profile")) {
                HStack {
                    AsyncImage(url: URL(string: vm.user?.avatar_url ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(.circle)

                    VStack(alignment: .leading) {
                        Text(vm.user?.login ?? "")
                        Text(vm.user?.bio ?? "") // getting nil from response
                            .font(.subheadline)
                            .lineLimit(2)
                        Text("Followers: \(vm.user?.followers ?? 0)")
                        Text("Repos: \(vm.user?.public_repos ?? 0)")
                    }
                }
            }

            Section(header: Text("Repositories")) {
                ForEach(vm.repos) { repo in
                    VStack(alignment: .leading) {
                        Text(repo.name ?? "").bold()
                        if let stars = repo.stargazers_count {
                            Text("Stars: \(stars)")
                        }
                        HStack {
                            Label("\(repo.stargazers_count ?? 0)", systemImage: "star.fill")
                            Label("\(repo.forks_count ?? 0)", systemImage: "tuningfork")
                        }
                        .font(.footnote)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .navigationTitle("Details")
    }
}
