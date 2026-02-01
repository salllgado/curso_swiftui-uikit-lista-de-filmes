import Foundation

@Observable
final class MovieDetailViewModel {
    let movie: Movies
    var isFavorite: Bool = false

    init(movie: Movies) {
        self.movie = movie
    }
}
