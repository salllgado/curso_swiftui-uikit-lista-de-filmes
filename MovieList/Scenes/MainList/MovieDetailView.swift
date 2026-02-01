import SwiftUI

struct MovieDetailView: View {
    let movie: Movies

    @ViewBuilder
    private var posterImage: some View {
        if let url = movie.getPosterURL() {
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
            .frame(maxWidth: .infinity)
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

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                posterImage

                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.semibold)

                    if let vote = movie.voteAverage {
                        HStack(spacing: 6) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", vote))
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                }

                if let overview = movie.overview, !overview.isEmpty {
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
            movie: .init(
                id: 1,
                title: "Sample Movie",
                overview: "This is a long overview describing the movie plot and details.",
                voteAverage: 7.8,
                posterPath: "/sample.png"
            )
        )
    }
}
