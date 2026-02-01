import SwiftUI

struct MovieSearchView: View {
    @Environment(\.dismiss) private var dismiss

    let allMovies: [Movies]
    var onSelect: (Movies) -> Void

    @State private var query: String = ""
    @State private var suggestions: [String] = MovieSearchSuggestions.load()
    
    private var filteredMovies: [Movies] {
        guard !query.isEmpty else { return [] }
        return allMovies.filter { $0.title.lowercased().contains(query.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search movies...", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if query.isEmpty {
                    // Show last suggestions
                    if suggestions.isEmpty {
                        Text("No recent searches")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        List {
                            Section(header: Text("Recent Searches")) {
                                ForEach(suggestions, id: \.self) { suggestion in
                                    Button(action: {
                                        query = suggestion
                                    }) {
                                        Text(suggestion)
                                    }
                                }
                                .onDelete(perform: deleteSuggestion)
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                } else {
                    List(filteredMovies) { movie in
                        Button(action: {
                            MovieSearchSuggestions.save(query: movie.title)
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
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            suggestions = MovieSearchSuggestions.load()
        }
    }
    
    private func deleteSuggestion(at offsets: IndexSet) {
        suggestions.remove(atOffsets: offsets)
        MovieSearchSuggestions.saveAll(suggestions)
    }
}

private struct MovieSearchSuggestions {
    private static let key = "recentMovieSearches"
    private static let maxCount = 10
    
    static func load() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    static func save(query: String) {
        var current = load()
        current.removeAll(where: { $0.caseInsensitiveCompare(query) == .orderedSame })
        current.insert(query, at: 0)
        if current.count > maxCount { current.removeLast() }
        UserDefaults.standard.setValue(current, forKey: key)
    }
    
    static func saveAll(_ queries: [String]) {
        let trimmed = Array(queries.prefix(maxCount))
        UserDefaults.standard.setValue(trimmed, forKey: key)
    }
}
