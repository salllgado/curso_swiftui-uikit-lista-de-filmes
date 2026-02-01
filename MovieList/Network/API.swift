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
        return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMTY5NGMxOTllYzI2ODM0NmU2MzdiYzA0MGZhZDUxOCIsIm5iZiI6MTU1ODg5MTQ2Ni41ODYsInN1YiI6IjVjZWFjYmNhMGUwYTI2NjQzZmNkMzViMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DfLd7Z-h7dMuvZF5w-WNW-RfOWtky6qolFzHbAUPKp4"]
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
