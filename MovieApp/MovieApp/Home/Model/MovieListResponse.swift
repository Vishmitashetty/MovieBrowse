//
//  MovieList.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?
}

struct Movie: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let voteAverage: Float?
    let voteCount: Float?
    let posterPath: String?
    let releaseDate: String?
}
