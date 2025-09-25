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
            ZStack {
                List(viewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                        
                        MovieRowView(movie: movie)
                            .padding(.vertical, 8)
                    }
                }
                .refreshable {
                    await viewModel.fetchPopularMovies()
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
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil), actions : {
                Button("Retry") {
                    Task {
                        await viewModel.fetchPopularMovies()
                    }
                }
                Button("Cancel", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            }, message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            })
        }
    }
}



#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
