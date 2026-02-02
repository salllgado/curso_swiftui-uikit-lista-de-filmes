import Foundation

@Observable
final class MovieDetailViewModel {
    let favoriteRepository: FavoriteRepository?
    let movie: Movies
    var isFavorite: Bool = false

    init(movie: Movies, favoriteRepository: FavoriteRepository?) {
        self.movie = movie
        self.favoriteRepository = favoriteRepository
    }
    
    func loadFavoriteState() {
        do {
            self.isFavorite = try favoriteRepository?.isFavorite(movieID: movie.id) ?? false
        } catch {
            self.isFavorite = false
        }
    }

    func favorite() {
        do {
            try favoriteRepository?.addFavorite(movie: movie)
            isFavorite.toggle()
        } catch {
            // ...
        }
    }
    
    func remove() {
        do {
            try favoriteRepository?.removeFavorite(movieID: movie.id)
            isFavorite.toggle()
        } catch {
            // ...
        }
    }
}
