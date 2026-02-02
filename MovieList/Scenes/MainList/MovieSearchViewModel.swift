import Foundation

protocol MovieSearchViewModelProtocol {
    var movies: [Movies] { get }
    func search(text: String) async
}

@Observable
final class MovieSearchViewModel: MovieSearchViewModelProtocol {
    private(set) var movies: [Movies] = []
    private let networkManager: NetworkManagerProtocol
    let favoriteRepository: FavoriteRepository?
    
    init(
        networkManager: NetworkManagerProtocol = NetworkManager(),
        favoriteRepository: FavoriteRepository?
    ) {
        self.networkManager = networkManager
        self.favoriteRepository = favoriteRepository
    }
    
    func search(text: String) {
        Task {
            do {
                let response: PopularFilmsResponse = try await networkManager.request(.search(query: text, page: 1))
                self.movies = response.results
            } catch let error {
                print("error: \(error)")
            }
        }
    }
}
