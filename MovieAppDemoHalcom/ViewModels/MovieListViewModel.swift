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
    @Published var searchText: String = ""
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.localizedCaseInsensitiveContains(searchText)}
        }
    }
    
    private let service = MovieAPIService()
    private let favoritesKey = "favoriteMovieIDs"
    
    //MARK: - Pagination state
    
    @Published var isPaginating = false
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var isLoadingPage = false
    
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
    
    func fetchPopularMovies(reset: Bool = false) async {
        
        guard !isLoadingPage else { return }
        guard currentPage <= totalPages else { return }
        
        isLoading = reset
        isLoadingPage = true
        errorMessage = nil
        
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
