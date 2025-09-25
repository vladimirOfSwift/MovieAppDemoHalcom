//
//  MovieListView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        HStack(alignment: .top, spacing: 10) {
                            if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                                AsyncImage(url: url)
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(5)
                            } else {
                                Color.gray.frame(width: 80, height: 120)
                                    .cornerRadius(5)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(movie.title)
                                    .font(.headline)
                                    .lineLimit(2)
                                if let releaseDate = movie.releaseDate {
                                    Text("Release date: \(releaseDate)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                if let overview = movie.overview {
                                    Text(overview)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .lineLimit(3)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
                .disabled(viewModel.isLoading)
                
                if viewModel.isLoading {
                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 8) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                        Text("Loading popular movies...")
                            .font(.subheadline)
                    }
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .padding(40)
                }
                
              
            }
            .navigationTitle("Popular Movies")
            .task {
                await viewModel.fetchPopularMovies()
            }
        }
    }
}



#Preview {
    MovieListView()
}
