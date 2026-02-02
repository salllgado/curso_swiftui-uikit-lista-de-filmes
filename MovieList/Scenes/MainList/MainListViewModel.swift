//
//  MainListViewModel.swift
//  MovieList
//
//  Created by Chrystian Salgado on 28/01/26.
//

import Foundation

protocol MainListViewModelProtocol: AnyObject {
    func loadData() async throws -> [MovieModel]
}

final class MainListViewModel: MainListViewModelProtocol {
    
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
