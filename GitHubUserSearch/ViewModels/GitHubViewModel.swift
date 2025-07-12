//
//  GitHubViewModel.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//
import Foundation

class GitHubViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var user: GitHubUser?
    @Published var repos: [GitHubRepo] = []
    @Published var errorMessage: String?

    private func fetchRepos(completionHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            completionHandler("Invalid repo URL")
            return
        }

        NetworkManager.shared.performGetRequest(url: url, responseType: [GitHubRepo].self) { result in
            switch result {
            case .success(let repos):
                self.repos = repos
                print(":::::::::::::: GutHub repos API Response Parameter :::::::::::::: \(repos)")
                completionHandler(nil)
            case .failure:
                print(":::::::::::::: GutHub repos failed ::::::::::::::")
                completionHandler("Could not fetch repositories")
            }
        }
    }
    
    var isValidUser: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func searchUser(completionHandler: @escaping (String?) -> Void) {
        guard let url = getUrl(url: "https://api.github.com/users/\(username)") else {
            completionHandler("Invalid URL")
            return
        }

        NetworkManager.shared.performGetRequest(url: url, responseType: GitHubUser.self) { result in
            switch result {
            case .success(let user):
                self.user = user
                print(":::::::::::::: GutHub User API Response Parameter ::::::::::::::: \(user)")
                // calling repos API
                
                self.fetchRepos { repoError in
                    if let repoError = repoError {
                        completionHandler(repoError)
                    } else {
                        completionHandler(nil)
                    }
                }
            case .failure:
                print(":::::::::::::: GutHub user API failed ::::::::::::::")
                completionHandler("User not found")
            }
        }
    }

    private func getUrl(url:String) -> URL? {
        return URL(string: url)
    }
    
//    private func fetchUser() {
//        guard let url = getUrl(url: "https://api.github.com/users/\(username)/repos") else { return }
//        
//        NetworkManager.shared.performGetRequest(url: url, responseType: GitHubUser.self) { result in
//            switch result {
//            case .success(let user):
//                self.user = user
//                self.fetchRepos()
//            case .failure:
//                self.errorMessage = "User not found"
//            }
//        }
//    }
}
