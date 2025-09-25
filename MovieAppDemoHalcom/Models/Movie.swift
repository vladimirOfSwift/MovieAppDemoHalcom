//
//  Movie.swift
//  MovieAppDemoHalcom
//
//  Created by Vladimir Savic on 25. 9. 2025..
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool?
    let originalLanguage: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case originalLanguage = "original_language"
    }
}
