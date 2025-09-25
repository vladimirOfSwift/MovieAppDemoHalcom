//
//  MovieDecodingTests.swift
//  MovieAppDemoHalcomTests
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import XCTest
@testable import MovieAppDemoHalcom

final class MovieDecodingTests: XCTestCase {
    
    func testMovieResponseDecoding_fromLocalJSON() throws {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "popular_movies", withExtension: "json") else {
            XCTFail("Missing resource: popular_movies.json in test bundle")
            return
        }
        
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(MovieResponse.self, from: data)
        
        XCTAssertEqual(response.page ?? 0, 1)
        XCTAssertEqual(response.results.count, 2)
        XCTAssertEqual(response.totalPages, 100)
        XCTAssertEqual(response.totalResults, 2000)
        
        let first = response.results[0]
        XCTAssertEqual(first.id, 550)
        XCTAssertEqual(first.title, "Fight Club")
        XCTAssertEqual(first.posterPath, "/a26cQPRhJPX6GbWfQbvZdrrp9j9.jpg")
        XCTAssertEqual(first.releaseDate, "1999-10-12")
        XCTAssertEqual(first.voteAverage, 8.4)
    }
    
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
}
