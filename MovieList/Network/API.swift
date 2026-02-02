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
    case search(query: String, page: Int)
    
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
        case .popular:
            return "movie/popular"
        case .search:
            return "search/movie"
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
    
    var queryParameters: [URLQueryItem] {
        switch self {
        case let .popular(page):
            return [.init(name: "page", value: String(page)), .init(name: "language", value: "en-US")]
        case let .search(query, page):
            return [.init(name: "query", value: query), .init(name: "language", value: "en-US"), .init(name: "page", value: String(page))]
        case .posterPath:
            return []
        }
    }
    
    var method: APIMethod {
        switch self {
        case .popular, .posterPath, .search:
            return .get
        }
    }
    
    func buildURL() -> URL? {
        var url: URL? = URL(string: baseURL + endpoint)
        url?.append(queryItems: queryParameters)
        return url
    }
}
