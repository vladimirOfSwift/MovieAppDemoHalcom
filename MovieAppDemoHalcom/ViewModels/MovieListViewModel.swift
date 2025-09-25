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
    @Published var favoriteMovieIDs: Set<Int> = [] {
        didSet {
            saveFavorites()
        }
    }
    
    private let service = MovieAPIService()
    private let favoritesKey = "favoriteMovieIDs"
    
    init() {
        loadFavorites()
    }
    
    //MARK: - Persistence
    
    private func saveFavorites() {
        let array = Array(favoriteMovieIDs)
        UserDefaults.standard.set(array, forKey: favoritesKey)
    }
    
    private func loadFavorites() {
        if let array = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] {
            favoriteMovieIDs = Set(array)
        }
    }
    
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
    
    func isFavorite(_ movie: Movie) -> Bool {
        favoriteMovieIDs.contains(movie.id)
    }
    
    func toggleFavorite(_ movie: Movie) {
        if favoriteMovieIDs.contains(movie.id) {
            favoriteMovieIDs.remove(movie.id)
        } else {
            favoriteMovieIDs.insert(movie.id)
        }
    }
}
