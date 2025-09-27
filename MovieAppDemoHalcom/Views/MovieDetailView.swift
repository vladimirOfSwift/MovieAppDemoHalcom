//
//  MovieDetailView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject var viewModel: MovieListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                    AsyncImage(url: url)
                        .frame(width: 200, height: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                HStack {
                    Text(movie.title)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.toggleFavorite(movie)
                    }) {
                        Image(systemName: viewModel.isFavorite(movie) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
                
                if let releaseDate = movie.releaseDate {
                    Text("Release date: \(releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Rating: \(String(format: "%.1f", movie.voteAverage))/10")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let adult = movie.adult {
                    Text("Adult: \(adult ? "Yes" : "No")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Original language: \(movie.originalLanguage)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Vote count: \(movie.voteCount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(movie.overview ?? "No overview")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    MovieDetailView()
//}
