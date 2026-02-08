//
//  FavoriteListView.swift
//  MovieList
//
//  Created by Chrystian Salgado on 02/02/26.
//

import SwiftUI

struct FavoriteListView: View {
    
    @State var viewModel: FavoriteListViewModel
    var onSelect: (_ movie: MovieModel) -> Void
    
    init(
        viewModel: FavoriteListViewModel,
        onSelect: @escaping (_ movie: MovieModel) -> Void
    ) {
        self.viewModel = viewModel
        self.onSelect = onSelect
    }
    
    var body: some View {
        List(viewModel.movies) { movie in
            Button {
                self.onSelect(movie)
            } label: {
                MovieCellView(movie: movie)
            }
        }
        .navigationTitle("Favoritos")
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
    FavoriteListView(
        viewModel: .init(
            movies: movies,
            favoriteRepository: nil
        ),
        onSelect: { _ in
        }
    )
}
