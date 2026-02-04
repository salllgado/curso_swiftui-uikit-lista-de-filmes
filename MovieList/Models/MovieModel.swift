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
    let overview: String?
    let voteAverage: Double?
    
    init(
        id: Int,
        title: String,
        posterPath: String?,
        overview: String?,
        voteAverage: Double?
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.voteAverage = voteAverage
    }
    
    init(favoriteMovie: FavoriteMovie) {
        id = favoriteMovie.id
        title = favoriteMovie.title
        posterPath = favoriteMovie.posterPath
        overview = favoriteMovie.overview
        voteAverage = favoriteMovie.voteAverage
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    func getPosterURL() -> URL? {
        if let posterPath {
            return API.posterPath(path: posterPath).buildURL()
        }
        
        return nil
    }
    
    func toFavoriteModel() -> FavoriteMovie {
        .init(id: id, title: title, posterPath: posterPath, overview: overview, voteAverage: voteAverage)
    }
}
