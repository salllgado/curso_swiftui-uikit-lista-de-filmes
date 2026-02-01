import SwiftUI

struct MovieSearchView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var viewModel: MovieSearchViewModel = .init()
    @State private var query: String = ""
    
    var onSelect: (Movies) -> Void

    init(onSelect: @escaping (Movies) -> Void) {
        self.onSelect = onSelect
    }

    private var filteredMovies: [Movies] {
        guard !query.isEmpty else { return [] }
        return viewModel.movies.filter { $0.title.lowercased().contains(query.lowercased()) }
    }
    
    @ViewBuilder
    var searchTextField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search movies...", text: $query)
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
    
    var body: some View {
        NavigationView {
            VStack {
                searchTextField
                
                if query.isEmpty {
                    Spacer()
                    Text("Type something to search")
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                } else {
                    List(filteredMovies) { movie in
                        Button(action: {
                            onSelect(movie)
                            dismiss()
                        }) {
                            MovieCellView(movie: movie)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                Spacer()
            }
            .navigationTitle("Search")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                viewModel.load()
            }
        }
    }
}

