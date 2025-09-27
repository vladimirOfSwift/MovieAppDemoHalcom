//
//  MovieDetailView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieTapped: Movie
    @ObservedObject var listViewModel: MovieListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                // Poster
                if let posterPath = movieTapped.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                    AsyncImage(url: url)
                        .frame(width: 200, height: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                // Title + favorite button
                HStack {
                    Text(movieTapped.title)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    Button(action: {
                        listViewModel.toggleFavorite(movieTapped)
                    }) {
                        Image(systemName: listViewModel.isFavorite(movieTapped) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
                
                // Other data coming from API
                if let releaseDate = movieTapped.releaseDate {
                    Text("Release date: \(releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Rating: \(String(format: "%.1f", movieTapped.voteAverage))/10")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if let adult = movieTapped.adult {
                    Text("Adult: \(adult ? "Yes" : "No")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Original language: \(movieTapped.originalLanguage)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Vote count: \(movieTapped.voteCount)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(movieTapped.overview ?? "No overview")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(movieTapped.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
