//
//  MovieDetailViewModel.swift
//  MovieList
//
//  Created by Chrystian Salgado on 02/02/26.
//

import SwiftUI

@Observable
final class MovieDetailViewModel {
    let movie: MovieModel
    let favoriteRepository: FavoriteRepository?
    var isFavorite: Bool
    
    init(movie: MovieModel, favoriteRepository: FavoriteRepository?, isFavorite: Bool = false) {
        self.movie = movie
        self.favoriteRepository = favoriteRepository
        self.isFavorite = isFavorite
    }
    
    func handleFavorite() {
        do {
            if isFavorite {
                try favoriteRepository?.removeFavorite(movieID: movie.id)
            } else {
                try favoriteRepository?.addFavorite(movie: movie)
            }
            self.isFavorite.toggle()
        } catch let error {
            print("## não foi possivel salvar \(error)")
        }
    }
    
    func loadFavoriteState() {
        do {
            self.isFavorite = try favoriteRepository?.isFavorite(movieID: movie.id) ?? false
        } catch let error {
            self.isFavorite = false
            print("## não foi verificar o estado de favorito do filme \(movie.title) - \(error)")
        }
    }
}
