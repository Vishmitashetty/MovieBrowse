//
//  SimilarMovieRepository.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation


protocol SimilarMovieRepositoryProtocol {
    func getSimilarMovies(movieId: Int?, pageNo: Int, completionHandler: @escaping (Result<SimilarMovieResponse, TaskError>) -> Void)
}

class SimilarMovieRepository: SimilarMovieRepositoryProtocol {
    
    static let shared = SimilarMovieRepository()
    private init() {}
    
    func getSimilarMovies(movieId: Int?, pageNo: Int, completionHandler: @escaping (Result<SimilarMovieResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        guard
            let movieId = movieId else { return }
        
        task.GET(api: MovieApiRoute.similar(movieId: String(movieId), pageNo: pageNo)) { (result: Result<SimilarMovieResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
