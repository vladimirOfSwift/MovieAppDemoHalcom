//
//  MovieRowView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
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
                if let releaseDate = movie.formattedReleaseDate {
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
    }
}

