//
//  FavoriteListViewModel.swift
//  MovieList
//
//  Created by Chrystian Salgado on 05/02/26.
//

import SwiftUI

@Observable
final class FavoriteListViewModel {
    
    private(set) var movies: [MovieModel]
    let favoriteRepository: FavoriteRepository?
    
    init(
        movies: [MovieModel] = [],
        favoriteRepository: FavoriteRepository?
    ) {
        self.movies = movies
        self.favoriteRepository = favoriteRepository
    }
    
    func loadFavorites() {
        do {
            self.movies = try favoriteRepository?.fetchFavorites().map({ MovieModel(favoriteMovie: $0) }) ?? []
        } catch let error {
            print("## erro ao carregar os favoritos - \(error)")
        }
    }
}
