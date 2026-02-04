//
//  MainListViewModel.swift
//  MovieList
//
//  Created by Chrystian Salgado on 28/01/26.
//

import Foundation

protocol MainListViewModelProtocol: AnyObject {
    var favoriteRepository: FavoriteRepository? { get }
    
    func loadData() async throws -> [MovieModel]
}

final class MainListViewModel: MainListViewModelProtocol {
    
    let favoriteRepository: FavoriteRepository?
    
    init(favoriteRepository: FavoriteRepository?) {
        self.favoriteRepository = favoriteRepository
    }
    
    // MARK: - Public methods
    func loadData() async throws -> [MovieModel] {
        return try await requestPopularFilms()
    }
}

extension MainListViewModel {
    func requestPopularFilms() async throws -> [MovieModel] {
        let response: PopularFilmsResponse = try await NetworkManager().request(.popular(page: 1))
        return response.results
    }
}
