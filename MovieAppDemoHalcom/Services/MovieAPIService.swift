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
   
    
    func fetchPopularMovies(page: Int = 1) async throws -> MovieResponse {
        
        guard var components = URLComponents(string: "\(baseURL)/movie/popular") else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)")
            ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw NSError(domain: "MovieAPIService", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP \(http.statusCode)"])
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(MovieResponse.self, from: data)
    }
}
