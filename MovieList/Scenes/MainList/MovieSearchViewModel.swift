import Foundation

protocol MovieSearchViewModelProtocol {
    var movies: [Movies] { get }
    func load()
}

@Observable
final class MovieSearchViewModel: MovieSearchViewModelProtocol {
    private(set) var movies: [Movies] = []
    
    init() {
        
    }
    
    func load() {
        
    }
}
