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
    let id: Int64?
    let title: String?
    let overview: String?
    let voteAverage: Float?
    let voteCount: Float?
    let posterPath: String?
    let releaseDate: String?
}

extension MovieListResponse {
    //Filter movie based on pattern match 
    func filterMovie(pattern: String) -> [Movie] {
        var movieList: [Movie] = []
        guard
            let results = results  else {return [] }
        results.forEach({ (movie) in
            guard let movieTitle = movie.title else {return}
            if movieTitle.searchString(patternValue: pattern) {
                movieList.append(movie)
            }
        })
        return movieList
    }
}
