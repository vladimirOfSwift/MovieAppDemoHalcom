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
            List(viewModel.movies) { movie in
                HStack {
                    if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                        AsyncImage(url: url)
                            .frame(width: 80, height: 120)
                    } else {
                        Color.gray.frame(width: 80, height: 120)
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(movie.title)
                            .font(.headline)
                        if let releaseDate = movie.releaseDate {
                            Text(releaseDate)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
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
