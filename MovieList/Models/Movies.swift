//
//  Movies.swift
//  MovieList
//
//  Created by Chrystian Salgado on 29/01/26.
//

import Foundation

struct PopularFilmsResponse: Codable {
    let results: [Movies]
}

struct Movies: Codable {
    let title: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }
    
    func getPosterURL() -> URL? {
        return API.posterPath(path: posterPath).buildURL()
    }
}
