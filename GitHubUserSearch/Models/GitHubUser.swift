//
//  GitHubUser.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//
import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatar_url: String
    let bio: String?
    let followers: Int
    let public_repos: Int
}


