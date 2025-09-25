//
//  MovieAPI.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import Foundation

final class MovieAPI {
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODk1MGZmZjRiMTJlZWUxMmFjYjAyMmQyZDMzYjY1YSIsIm5iZiI6MTc1ODcxNzMwNy41ODYsInN1YiI6IjY4ZDNlNTdiY2EwOGM2NmU3OWU3MWYyNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kDsG3wNSQn5kEM32jCbugCCSqhBc07tew2F6M5RTA5c"
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchPopularMovies(completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        
    }
}
