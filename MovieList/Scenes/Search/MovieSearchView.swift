//
//  MovieSearchView.swift
//  MovieList
//
//  Created by Chrystian Salgado on 02/02/26.
//

import SwiftUI

struct MovieSearchView: View {
    
    @Bindable private var viewModel: MovieSearchViewModel
    @State private var query: String
    
    var onSelect: (_ movie: MovieModel) -> Void
    
    init(
        viewModel: MovieSearchViewModel = .init(),
        query: String = "",
        onSelect: @escaping (_ movie: MovieModel) -> Void
    ) {
        self.viewModel = viewModel
        self.query = query
        self.onSelect = onSelect
    }
    
    @ViewBuilder
    private var searchTextField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Busque por filmes...", text: $query)
                .onSubmit({
                    self.viewModel.search(text: query)
                })
                .foregroundColor(.primary)
                .disableAutocorrection(true)
        }
        .padding(12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.secondary.opacity(0.12), lineWidth: 1)
        )
        .padding(.horizontal)
        .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
    }
    
    @ViewBuilder
    private var listView: some View {
        if query.isEmpty {
            Spacer()
            Text("Presquise por algum filme...")
                .padding()
            Spacer()
        } else {
            List(viewModel.movies) { movie in
                Button {
                    self.onSelect(movie)
                } label: {
                    MovieCellView(movie: movie)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            searchTextField
            listView
            Spacer()
        }
        .navigationTitle("Busca")
    }
}
