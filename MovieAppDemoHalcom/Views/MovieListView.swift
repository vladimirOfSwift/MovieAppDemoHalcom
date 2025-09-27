//
//  MovieListView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel: MovieListViewModel
    
    var body: some View {
        NavigationView {
            List {
                
                ForEach(viewModel.filteredMovies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                        MovieRowView(movie: movie)
                            .padding(.vertical, 8)
                            
                    }
                    .onAppear {
                        if movie.id == viewModel.filteredMovies.last?.id {
                            Task { await viewModel.fetchPopularMovies() }
                        }
                    }
                }
                
            if viewModel.isLoadingPage {
                    HStack {
                        Spacer()
                        ProgressView("Loading more movies...")
                            .padding()
                        Spacer()
                    }
                }
            }
            .listRowBackground(Color(.systemBackground))
            .listStyle(PlainListStyle())
            .refreshable {
                await viewModel.fetchPopularMovies(reset: true)
            }
            .disabled(viewModel.isLoading)
            .navigationTitle("Popular Movies")
            .searchable(text: $viewModel.searchText, prompt: "Search by title")
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button("Retry") {
                    Task { await viewModel.fetchPopularMovies(reset: true) }
                }
                Button("Cancel", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            }, message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            })
        }
        .task {
            await viewModel.fetchPopularMovies(reset: true)
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
