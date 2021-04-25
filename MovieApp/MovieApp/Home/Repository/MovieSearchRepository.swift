//
//  MovieSearchRepository.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//

import Foundation


protocol MovieSearchRepositoryProtocol {
    func getMovieBySearch(pageNo: Int, query: String, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void)
}

class MovieSearchRepository: MovieSearchRepositoryProtocol {
    
    static let shared = MovieSearchRepository()
    private init() {}
    
    func getMovieBySearch(pageNo: Int, query: String, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MovieApiRoute.search(query: query, pageNo: pageNo)) { (result: Result<MovieListResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
