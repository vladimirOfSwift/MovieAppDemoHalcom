//
//  MovieAPIService.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import Foundation

final class MovieAPIService {
    private let baseURL = "https://api.themoviedb.org/3"
    private let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmODk1MGZmZjRiMTJlZWUxMmFjYjAyMmQyZDMzYjY1YSIsIm5iZiI6MTc1ODcxNzMwNy41ODYsInN1YiI6IjY4ZDNlNTdiY2EwOGM2NmU3OWU3MWYyNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.kDsG3wNSQn5kEM32jCbugCCSqhBc07tew2F6M5RTA5c"
   
    
    func fetchPopularMovies() async throws -> MovieResponse {
        
        guard let url = URL(string: "\(baseURL)/trending/movie/day") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoder = JSONDecoder()
        return try decoder.decode(MovieResponse.self, from: data)
    }
}
