//
//  MockMovieCastRepository.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 25/04/21.
//

import Foundation
@testable import MovieApp

class MockMovieCastRepository: MovieCastRepositoryProtocol {
    
    static let shared = MockMovieCastRepository()
    private var movieCastResponse: MovieCastResponse?
    
    private init() {}
    
    func getMovieCast(movieId: Int?, completionHandler: @escaping (Result<MovieCastResponse, TaskError>) -> Void) {
        
        let path = Bundle(for: type(of: self)).path(forResource: "MovieCastResponse", ofType: "json")
        ProcessDummyJSON.sharedObject.processJSONResponse(path: path) { (result: Result<MovieCastResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.movieCastResponse = response
            case .failure:
                break
            }
            completionHandler(result)
        }
    }
    
    func getMovieCastResponse() -> MovieCastResponse? {
        return movieCastResponse
    }
}
