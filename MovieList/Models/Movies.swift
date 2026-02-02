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

struct Movies: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let voteAverage: Double?
    let posterPath: String?
    
    init(
        id: Int,
        title: String,
        overview: String? = nil,
        voteAverage: Double? = nil,
        posterPath: String?
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.posterPath = posterPath
    }
    
    init(favorite: FavoriteMovie) {
        id = favorite.id
        title = favorite.title
        overview = favorite.overview
        voteAverage = favorite.voteAverage
        posterPath = favorite.posterPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    func getPosterURL() -> URL? {
        if let posterPath {
            return API.posterPath(path: posterPath).buildURL()
        }
        
        return nil
    }
    
    func toFavoriteModel() -> FavoriteMovie {
        .init(
            id: id,
            title: title,
            posterPath: posterPath,
            voteAverage: voteAverage,
            overview: overview
        )
    }
}
