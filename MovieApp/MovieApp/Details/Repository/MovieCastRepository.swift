//
//  MovieCastRepository.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation


protocol MovieCastRepositoryProtocol {
    func getMovieCast(movieId: Int?, completionHandler: @escaping (Result<MovieCastResponse, TaskError>) -> Void)
}

class MovieCastRepository: MovieCastRepositoryProtocol {
    
    static let shared = MovieCastRepository()
    private init() {}
    
    func getMovieCast(movieId: Int?, completionHandler: @escaping (Result<MovieCastResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        guard
            let movieId = movieId else { return }
        
        task.GET(api: MovieApiRoute.credits(movieId: String(movieId))) { (result: Result<MovieCastResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
