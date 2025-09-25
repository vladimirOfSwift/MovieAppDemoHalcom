//
//  MovieDetailView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") {
                    AsyncImage(url: url)
                        .frame(width: 200, height: 300)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.bottom, 16)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                Text(movie.title)
                    .font(.title)
                    .bold()
                
                if let releaseDate = movie.releaseDate {
                    Text("Release date: \(releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Rating: \(String(format: "%.1f", movie.voteAverage))/10")
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
