import Foundation

protocol MovieSearchViewModelProtocol: ObservableObject {
    var movies: [Movies] { get }
    func load()
}

final class MovieSearchViewModel: MovieSearchViewModelProtocol {
    @Published private(set) var movies: [Movies] = []
    
    private let repository: MainListViewModelProtocol
    
    init(repository: MainListViewModelProtocol = MainListViewModel()) {
        self.repository = repository
    }
    
    func load() {
        Task {
            do {
                let loaded = try await repository.loadData()
                DispatchQueue.main.async {
                    self.movies = loaded
                }
            } catch {
                // Handle error as needed
                DispatchQueue.main.async {
                    self.movies = []
                }
            }
        }
    }
}
