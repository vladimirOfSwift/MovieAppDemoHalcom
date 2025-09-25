//
//  MovieListViewModel.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI
import Combine

@MainActor
final class MovieListViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = MovieAPIService()
    
    func fetchPopularMovies() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let response = try await service.fetchPopularMovies()
            movies = response.results
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
