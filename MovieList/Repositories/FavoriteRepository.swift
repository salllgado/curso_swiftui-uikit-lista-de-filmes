//
//  FavoriteRepository.swift
//  MovieList
//
//  Created by Chrystian Salgado on 02/02/26.
//

import Foundation
import SwiftData

@Model
final class FavoriteMovie {
    @Attribute(.unique)
    var id: Int
    
    var title: String
    var posterPath: String?
    var overview: String?
    var voteAverage: Double?
    
    init(
        id: Int,
        title: String,
        posterPath: String? = nil,
        overview: String? = nil,
        voteAverage: Double? = nil
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.voteAverage = voteAverage
    }
}

@Observable
final class FavoriteRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchFavorites() throws -> [FavoriteMovie] {
        let descriptor = FetchDescriptor<FavoriteMovie>()
        return try context.fetch(descriptor)
    }
    
    func isFavorite(movieID: Int) throws -> Bool {
        let descriptor = FetchDescriptor<FavoriteMovie>(predicate: #Predicate { $0.id == movieID })
        let result = try context.fetch(descriptor)
        return !result.isEmpty
    }
    
    func addFavorite(movie: MovieModel) throws {
        guard try !isFavorite(movieID: movie.id) else { return }
        context.insert(movie.toFavoriteModel())
        try context.save()
    }
    
    func removeFavorite(movieID: Int) throws {
        let descriptor = FetchDescriptor<FavoriteMovie>(predicate: #Predicate { $0.id == movieID })
        let result = try context.fetch(descriptor)
        for favorite in result {
            context.delete(favorite)
        }
        try context.save()
    }
}

