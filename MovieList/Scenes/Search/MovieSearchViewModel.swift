//
//  MovieSearchViewModel.swift
//  MovieList
//
//  Created by Chrystian Salgado on 02/02/26.
//

import SwiftUI

@Observable
final class MovieSearchViewModel {
    private(set) var movies: [MovieModel] = []
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func search(text: String) {
        Task {
            do {
                let response: PopularFilmsResponse = try await networkManager.request(.search(query: text, page: 1))
                self.movies = response.results
            } catch let error {
                print("## ocorreu um erro: \(error)")
            }
        }
    }
}
