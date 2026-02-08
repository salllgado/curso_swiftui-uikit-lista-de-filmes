//
//  MovieDetailView.swift
//  MovieList
//
//  Created by Chrystian Salgado on 02/02/26.
//

import SwiftUI

struct MovieDetailView: View {
    
    @State var viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    private var posterImage: some View {
        if let url = viewModel.movie.getPosterURL() {
            AsyncImage(url: url) { state in
                switch state {
                case .empty:
                    ZStack {
                        ProgressView()
                            .frame(width: 40.0, height: 40.0)
                    }
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                case .failure:
                    defaultPosterImage
                @unknown default:
                    defaultPosterImage
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 200.0)
        } else {
            defaultPosterImage
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
    
    @ViewBuilder
    private var defaultPosterImage: some View {
        Image(systemName: "film")
            .resizable()
            .scaledToFit()
            .foregroundColor(.brown)
            .padding(24)
    }
    
    @ViewBuilder
    private var favoriteButton: some View {
        Button(action: {
            viewModel.handleFavorite()
        }) {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(.red)
                .padding(12)
                .background(.ultraThinMaterial, in: Circle())
                .overlay(
                    Circle().stroke(Color.white.opacity(0.6), lineWidth: 1)
                )
        }
        .shadow(radius: 3, y: 1)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                posterImage
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(viewModel.movie.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                        Spacer()
                        favoriteButton
                    }
                    if let rating = viewModel.movie.voteAverage {
                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", rating))
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    if let movieOverview = viewModel.movie.overview {
                        Divider()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Overview")
                                .font(.headline)
                            Text(movieOverview)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("Detalhes")
        .background(Color(.systemBackground))
        .task(priority: .background) {
            viewModel.loadFavoriteState()
        }
    }
}

#Preview {
    MovieDetailView(
        viewModel: .init(
            movie: .init(
                id: 1,
                title: "Up Altas Aventuras",
                posterPath: nil,
                overview: "Descrição mocada",
                voteAverage: 8.0
            ), favoriteRepository: nil
        )
    )
}
