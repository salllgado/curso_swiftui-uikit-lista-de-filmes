//
//  FavoriteRepository.swift
//  MovieList
//
//  Created by Chrystian Salgado on 01/02/26.
//

import Foundation
import SwiftData
import UIKit

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
    
    func addFavorite(movie: Movies) throws {
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

