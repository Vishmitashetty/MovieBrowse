//
//  MockMovieListRepository.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation
@testable import MovieApp

class MockMovieListRepository: MovieListRepositoryProtocol {
    
    static let shared = MockMovieListRepository()
    private var movieList: MovieListResponse?
    
    private init() {}
    
    func getNowPlaying(pageNo: Int, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void) {
        let path = Bundle(for: type(of: self)).path(forResource: "GetNowPlayingResponse", ofType: "json")
        ProcessDummyJSON.sharedObject.processJSONResponse(path: path) { (result: Result<MovieListResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieList = response
            case .failure:
                break
            }
            completionHandler(result)
        }
    }
    
    func getMovieList() -> MovieListResponse? {
        return movieList ?? nil
    }
}
