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
    @Published var errorMessage: String? = nil
    
    private let service = MovieAPIService()
    
    func fetchPopularMovies() async {
        isLoading = true
        errorMessage = nil
        
        if ProcessInfo.processInfo.arguments.contains("-UITestErrorCase") {
            self.errorMessage = "Fake error for UI testing"
            isLoading = false
            return
        }
        
        do {
            let response = try await service.fetchPopularMovies()
            movies = response.results
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
}
