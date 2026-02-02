//
//  NetworkManager.swift
//  MovieList
//
//  Created by Chrystian Salgado on 29/01/26.
//

import Foundation

protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ api: API) async throws -> T
}

final class NetworkManager: NetworkManagerProtocol {
    
    func request<T: Decodable>(_ api: API) async throws -> T {
        guard let url = api.buildURL() else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        api.headers.forEach { (key: String, value: String) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return try await decodeRequest(request)
    }
    
    // MARK: - Generic decode helper
    private func decodeRequest<T: Decodable>(_ request: URLRequest, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        print("requesting: " + request.url!.absoluteString)
        let (data, _) = try await URLSession.shared.data(for: request)
        print("response: " + (String(data: data, encoding: .utf8) ?? ""))
        return try decoder.decode(T.self, from: data)
    }
}
