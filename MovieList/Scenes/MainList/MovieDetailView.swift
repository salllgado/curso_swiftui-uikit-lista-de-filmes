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
                        Color.gray.opacity(0.1)
                        ProgressView()
                    }
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.brown)
                        .padding(24)
                @unknown default:
                    Image(systemName: "film")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.brown)
                        .padding(24)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 200.0)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        } else {
            Image(systemName: "film")
                .resizable()
                .scaledToFit()
                .foregroundColor(.brown)
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
    
    private var favoriteButton: some View {
        Button(action: {
            viewModel.isFavorite.toggle()
        }) {
            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                .foregroundColor(viewModel.isFavorite ? .red : .primary)
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
            VStack(alignment: .leading, spacing: 16) {
                posterImage
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(viewModel.movie.title)
                            .font(.title)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .minimumScaleFactor(0.8)
                        Spacer()
                        favoriteButton
                    }
                    if let vote = viewModel.movie.voteAverage {
                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", vote))
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                if let overview = viewModel.movie.overview, !overview.isEmpty {
                    Divider()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Overview")
                            .font(.headline)
                        Text(overview)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemBackground))
    }
}

#Preview {
    NavigationView {
        MovieDetailView(
            viewModel: MovieDetailViewModel(
                movie: .init(
                    id: 1,
                    title: "Sample Movie",
                    overview: "This is a long overview describing the movie plot and details.",
                    voteAverage: 7.8,
                    posterPath: "/sample.png"
                )
            )
        )
    }
}
