//
//  FavoritesListView.swift
//  MovieList
//
//  Created by Chrystian Salgado on 01/02/26.
//

import SwiftUI

@Observable
final class FavoritesViewModel {
    private let favoriteRepository: FavoriteRepository
    private(set) var favorites: [Movies] = []

    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }
    
    func loadFavorites() {
        do {
            let favoriteModels = try favoriteRepository.fetchFavorites()
            favorites = favoriteModels.compactMap { Movies(favorite: $0) }
        } catch {
            favorites = []
        }
    }
}

struct FavoritesListView: View {
    @State var viewModel: FavoritesViewModel
    let onSelect: (Movies) -> Void
    let onClose: () -> Void

    init(
        favoriteRepository: FavoriteRepository,
        onSelect: @escaping (Movies) -> Void,
        onClose: @escaping () -> Void
    ) {
        self.viewModel = .init(favoriteRepository: favoriteRepository)
        self.onSelect = onSelect
        self.onClose = onClose
    }
    
    var body: some View {
        VStack {
            if viewModel.favorites.isEmpty {
                Spacer()
                Text("Nenhum item favoritado")
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
            } else {
                List {
                    ForEach(viewModel.favorites) { movie in
                        Button(action: { onSelect(movie) }) {
                            MovieCellView(movie: movie)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favoritos")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                }
            }
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}
