//
//  MovieModel.swift
//  MovieList
//
//  Created by Chrystian Salgado on 29/01/26.
//

import Foundation

struct PopularFilmsResponse: Codable {
    let results: [MovieModel]
}

struct MovieModel: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
    
    func getPosterURL() -> URL? {
        if let posterPath {
            return API.posterPath(path: posterPath).buildURL()
        }
        
        return nil
    }
}
