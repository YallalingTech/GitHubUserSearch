//
//  GitHubRepo.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//
import Foundation

struct GitHubRepo: Codable, Identifiable {
    let id:Int?
    var name: String?
    var description: String?
    var stargazers_count: Int?
    var forks_count: Int?
}
