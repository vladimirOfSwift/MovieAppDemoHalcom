//
//  MovieAppDemoHalcomUnitTests.swift
//  MovieAppDemoHalcomUnitTests
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import XCTest
@testable import MovieAppDemoHalcom

@MainActor final class MovieAppDemoHalcomUnitTests: XCTestCase {
    
    func testFetchPopularMovies() async {
        let service = MovieAPIService()
        
        do {
            let response = try await service.fetchPopularMovies()
            print("Fetched \(response.results.count) movies")
            if let first = response.results.first {
                print("First movie: \(first.title)")
            }
        } catch {
            print("Error fetching movies: \(error)")
        }
    }
    
    func testFavoritesPersistence() {
        let viewModel = MovieListViewModel()
        
        viewModel.favoriteMovieIDs = []
        
        viewModel.favoriteMovieIDs.insert(123)
        
        let newViewModel = MovieListViewModel()
        
        XCTAssertTrue(newViewModel.favoriteMovieIDs.contains(123), "Favorite movie IDs not persisted")
        
        UserDefaults.standard.removeObject(forKey: "favoriteMovieIDs")
    }
    
    func testToggleFavorite_addsAndRemovesMovieID() {
        let viewModel = MovieListViewModel()
        
        viewModel.favoriteMovieIDs = []
        
        let testMovieID = 25
        let testMovie = Movie(
            id: testMovieID,
            title: "Test Movie",
            overview: nil,
            posterPath:  nil,
            releaseDate: nil,
           voteAverage: 0.0,
            voteCount: 0,
            adult: nil,
            originalLanguage: "en"
        )
        
        viewModel.toggleFavorite(testMovie)
        XCTAssertTrue(viewModel.favoriteMovieIDs.contains(testMovieID), "Test movie ID should be added after first toggle")
        
        viewModel.toggleFavorite(testMovie)
        XCTAssertFalse(viewModel.favoriteMovieIDs.contains(testMovieID), "Test movie ID should be removed after second toggle")
        
        UserDefaults.standard.removeObject(forKey: "favoriteMovieIDs")
        
    }
}
