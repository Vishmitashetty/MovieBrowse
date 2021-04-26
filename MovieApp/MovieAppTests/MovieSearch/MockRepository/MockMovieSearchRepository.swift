//
//  MockMovieSearchRepository.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 26/04/21.
//

import Foundation
@testable import MovieApp

class MockMovieSearchRepository: MovieSearchRepositoryProtocol {
    
    static let shared = MockMovieSearchRepository()
    private var movieSearchResponse: MovieListResponse?
    
    private init() {}
    
    func getMovieBySearch(pageNo: Int, query: String, completionHandler: @escaping (Result<MovieListResponse, TaskError>) -> Void) {
        
        let path = Bundle(for: type(of: self)).path(forResource: "MovieSearch", ofType: "json")
        ProcessDummyJSON.sharedObject.processJSONResponse(path: path) { (result: Result<MovieListResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieSearchResponse = response
            case .failure:
                break
            }
            completionHandler(result)
        }
    }
    
    func getMovieSearch() -> MovieListResponse? {
        return movieSearchResponse
    }
}
