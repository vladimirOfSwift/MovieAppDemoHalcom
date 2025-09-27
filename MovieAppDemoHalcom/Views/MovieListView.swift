//
//  MovieListView.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI
///Displays a list of popular movies with pagination, search and error handling
struct MovieListView: View {
    
    @StateObject var viewModel: MovieListViewModel
    
    var body: some View {
        NavigationView {
            List {
                movieRows
                loadingFooter
            }
            .listRowBackground(Color(.systemBackground))
            .listStyle(PlainListStyle())
            .refreshable { await viewModel.fetchPopularMovies(reset: true) }
            .disabled(viewModel.isLoading)
            .navigationTitle("Popular Movies")
            .searchable(text: $viewModel.searchText, prompt: "Search by title")
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions: {
                Button("Retry") { Task { await viewModel.fetchPopularMovies(reset: true) } }
                Button("Cancel", role: .cancel) { viewModel.errorMessage = nil }
            }, message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            })
        }
        .task { await viewModel.fetchPopularMovies(reset: true) }
    }
    
    //MARK: - Movie Rows
    private var movieRows: some View {
        ForEach(viewModel.filteredMovies) { movie in
            NavigationLink(destination: MovieDetailView(movieTapped: movie, listViewModel: viewModel)) {
                MovieRowView(movie: movie)
                    .padding(.vertical, 8)
                
            }
            .onAppear {
                // Trigger automatic pagination when the last movie appears
                if movie.id == viewModel.filteredMovies.last?.id {
                    Task { await viewModel.fetchPopularMovies() }
                }
            }
        }
    }
    
    //MARK: - Pagination Footer
    private var loadingFooter: some View {
        Group {
            if viewModel.isLoadingPage {
                HStack {
                    Spacer()
                    ProgressView("Loading more movies...")
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
