//
//  SynoypsisResponse.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation

struct SynoypsisResponse: Codable {
    let id: Int?
    let imdbId: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let popularity: Float?
    let budget: Int?
    let releaseDate: String?
    let revenue: Int?
    let status: String?
    let voteAverage: Float?
    let voteCount: Int?
}
