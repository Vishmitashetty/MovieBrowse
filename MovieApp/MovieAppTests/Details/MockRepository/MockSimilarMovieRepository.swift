//
//  MockSimilarMovieRepository.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 25/04/21.
//

import Foundation
@testable import MovieApp

class MockSimilarMovieRepository: SimilarMovieRepositoryProtocol {
    
    static let shared = MockSimilarMovieRepository()
    private var similarMovieResponse: SimilarMovieResponse?
    
    private init() {}
    
    func getSimilarMovies(movieId: Int?, pageNo: Int, completionHandler: @escaping (Result<SimilarMovieResponse, TaskError>) -> Void) {
        let path = Bundle(for: type(of: self)).path(forResource: "SimilarMovieResponse", ofType: "json")
        ProcessDummyJSON.sharedObject.processJSONResponse(path: path) { (result: Result<SimilarMovieResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.similarMovieResponse = response
            case .failure:
                break
            }
            completionHandler(result)
        }
    }
    
    func getSimilarMovieResponse() -> SimilarMovieResponse? {
        return similarMovieResponse
    }
}
