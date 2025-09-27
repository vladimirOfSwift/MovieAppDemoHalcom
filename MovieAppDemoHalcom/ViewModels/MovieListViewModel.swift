//
//  MovieListViewModel.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import SwiftUI
import Combine

/// Manages state, data fetching, pagination, search, and favorites for the Movie list coming from TMDB API.
@MainActor
final class MovieListViewModel: ObservableObject {
    
    //MARK: - Published properties (View Binding)
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var favoriteMovieIDs: Set<Int> = [] {
        didSet {
            saveFavorites()
        }
    }
    @Published var searchText: String = ""
    
    /// Computed properties for filtered movies based on the user's input from search text
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    //MARK: - Private properties
    private let service = MovieAPIService()
    private let favoritesKey = "favoriteMovieIDs"
    
    //MARK: - Pagination State
    @Published var isPaginating = false
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var isLoadingPage = false
    
    //MARK: - Initialization
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
    
    //MARK: - Networking
    /// Fetches popular movies from the API, handles pagination and reset
    /// - Parameter reset: If true, clears movies and starts from page 1
    func fetchPopularMovies(reset: Bool = false) async {
        
        guard !isLoadingPage, currentPage <= totalPages else { return }
        
        isLoading = reset
        isLoadingPage = true
        errorMessage = nil
        
        // Fake error case for UI testing
        if ProcessInfo.processInfo.arguments.contains("-UITestErrorCase") {
            self.errorMessage = "Fake error for UI testing"
            isLoading = false
            return
        }
        
        if reset {
            currentPage = 1
            movies.removeAll()
        }
        
        do {
            let response = try await service.fetchPopularMovies(page: currentPage)
            movies.append(contentsOf: response.results)
            totalPages = response.totalPages ?? 1
            currentPage += 1
            
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
        isLoadingPage = false
    }
    /// Triggers loading more movies if the user reaches the last movie
    func loadMoreIfNeeded(currentMovie movie: Movie) async {
        guard let lastMovie = movies.last else { return }
        
        if movie.id == lastMovie.id {
            await fetchPopularMovies()
        }
    }
    
    //MARK: - Favorites
    
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
