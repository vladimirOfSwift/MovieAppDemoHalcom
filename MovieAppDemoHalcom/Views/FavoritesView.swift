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
            List(viewModel.movies.filter { viewModel.isFavorite($0) }) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                    MovieRowView(movie: movie)
                }
            }
            .navigationTitle("Favorite movies")
        }
    }
}

//#Preview {
//    FavoritesView()
//}
