//
//  API.swift
//  MovieList
//
//  Created by Chrystian Salgado on 29/01/26.
//

import Foundation

enum API {
    case popular(page: Int)
    case posterPath(path: String)
    
    var baseURL: String {
        switch self {
        case .posterPath:
            return "https://image.tmdb.org/t/p/"
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var endpoint: String {
        switch self {
        case let .popular(page):
            return "movie/popular?language=en-US&page=\(page)"
        case let .posterPath(path):
            return "w780\(path)"
        }
    }
    
    var headers: [String: String] {
        guard let apiKey = Bundle.main.secrets?["API_KEY"] as? String, !apiKey.isEmpty else {
            fatalError("TMDB API Key não encontrada. Adicione Secrets.plist (não comitar).")
        }

        return ["Authorization": "Bearer \(apiKey)"]
    }
    
    var method: APIMethod {
        switch self {
        case .popular, .posterPath:
            return .get
        }
    }
    
    func buildURL() -> URL? {
        return URL(string: baseURL + endpoint)
    }
}
