//
//  SimilarMovieResponse.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation

struct SimilarMovieResponse: Codable {
    let page: Int?
    let results: [SimilarMovie]
    let totalPages: Int?
    let totalResults: Int?
}

struct SimilarMovie: Codable {
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let voteAverage: Float?
    let voteCount: Int?
    let popularity: Float?
}
