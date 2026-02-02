import SwiftUI

struct MovieSearchView: View {
    @Bindable private var viewModel: MovieSearchViewModel
    @State private var query: String = ""
    
    var onSelect: (Movies) -> Void
    
    init(viewModel: MovieSearchViewModel, onSelect: @escaping (Movies) -> Void) {
        self.viewModel = viewModel
        self.onSelect = onSelect
    }
    
    @ViewBuilder
    var searchTextField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search movies...", text: $query)
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
    
    var body: some View {
        VStack {
            searchTextField
            if query.isEmpty {
                Spacer()
                Text("Pesquise alguma coisa...")
                    .foregroundColor(.secondary)
                    .padding()
                Spacer()
            } else {
                List(viewModel.movies) { movie in
                    Button(action: {
                        onSelect(movie)
                    }) {
                        MovieCellView(movie: movie)
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            Spacer()
        }
        .navigationTitle("Busca")
    }
}

