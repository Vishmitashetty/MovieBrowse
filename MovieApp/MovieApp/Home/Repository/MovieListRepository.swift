//
//  MovieListRepository.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation

protocol MovieListRepositoryProtocol {
    func getNowPlaying(pageNo: Int, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void)
}

class MovieListRepository: MovieListRepositoryProtocol {
    
    static let shared = MovieListRepository()
    private init() {}
    
    func getNowPlaying(pageNo: Int, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        task.GET(api: MovieApiRoute.home(pageNo: pageNo)) { (result: Result<MovieListResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
