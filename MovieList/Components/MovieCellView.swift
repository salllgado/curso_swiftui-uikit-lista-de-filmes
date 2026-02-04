//
//  MovieCellView.swift
//  MovieList
//
//  Created by Chrystian Salgado on 27/01/26.
//

import SwiftUI

struct MovieCellView: View {
    
    let movie: MovieModel
    
    @ViewBuilder
    private var defaultPosterImage: some View {
        Image(systemName: "film")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .foregroundColor(.brown)
    }
    
    @ViewBuilder
    private var posterImage: some View {
        if let url = movie.getPosterURL() {
            AsyncImage(url: url) { state in
                switch state {
                case .empty:
                    ProgressView()
                        .frame(width: 40, height: 40)
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                case .failure:
                    defaultPosterImage
                @unknown default:
                    defaultPosterImage
                }
            }
        } else {
            defaultPosterImage
        }
    }
    
    var body: some View {
        HStack {
            posterImage
            Text(movie.title)
                .lineLimit(2)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.brown)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    MovieCellView(
        movie: .init(
            id: 1,
            title: "Up Altas Aventuras",
            posterPath: nil,
            overview: "Filme infantil",
            voteAverage: 8.0
        )
    )
}
