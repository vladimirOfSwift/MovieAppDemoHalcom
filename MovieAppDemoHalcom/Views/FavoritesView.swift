//
//  FavoritesView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject  var viewModel: MovieListViewModel
    
    var body: some View {
        NavigationView {
            List {
                let favorites = viewModel.movies.filter { viewModel.isFavorite($0)}
                
                ForEach(favorites) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                        MovieRowView(movie: movie)
                    }
                }
                .onDelete { IndexSet in
                    withAnimation {
                        for index in IndexSet {
                            let movie = favorites[index]
                            viewModel.toggleFavorite(movie)
                        }
                    }
                }
            }
            .navigationTitle("Favorite movies")
        }
    }
}

//#Preview {
//    FavoritesView()
//}
