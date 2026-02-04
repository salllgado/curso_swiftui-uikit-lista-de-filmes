//
//  FavoriteListView.swift
//  MovieList
//
//  Created by Chrystian Salgado on 02/02/26.
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

struct FavoriteListView: View {
    
    @State var viewModel: FavoriteListViewModel
    
    init(viewModel: FavoriteListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Hello, World!")
            .task(priority: .background) {
                viewModel.loadFavorites()
            }
    }
}

#Preview {
    let movies: [MovieModel] = [
        .init(
            id: 1,
            title: "Up Altas Aventuras",
            posterPath: nil,
            overview: "Descrição 1",
            voteAverage: 8.0
        ),
        .init(
            id: 2,
            title: "Carros",
            posterPath: nil,
            overview: "Descrição 2",
            voteAverage: 9.0
        )
    ]
    FavoriteListView(viewModel: .init(movies: movies, favoriteRepository: nil))
}
