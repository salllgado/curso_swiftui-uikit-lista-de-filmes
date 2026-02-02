//
//  FavoriteMovie.swift
//  MovieList
//
//  Created by Chrystian Salgado on 01/02/26.
//

import SwiftData

@Model
final class FavoriteMovie {
    @Attribute(.unique)
    var id: Int
    var title: String
    var posterPath: String?
    var voteAverage: Double?
    var overview: String?
    
    init(id: Int, title: String, posterPath: String?, voteAverage: Double?, overview: String?) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.overview = overview
    }
}
