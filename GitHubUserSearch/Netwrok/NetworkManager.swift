//
//  APIService.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func performGetRequest<T: Decodable>(url: URL, responseType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }

                guard let data = data else {
                    completionHandler(.failure(NSError(domain: "No data", code: -1)))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    print("Response parameters:\(decoded)")
                    completionHandler(.success(decoded))
                } catch {
                    print("Decoding error:", error)
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
}


