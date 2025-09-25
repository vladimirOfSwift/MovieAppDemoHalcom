//
//  RootView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        TabView {
            MovieListView(viewModel: viewModel)
                .tabItem {
                    Label("Movies", systemImage: "film")
                }
            FavoritesView(viewModel: viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }
    }
}

#Preview {
    RootView()
}
