//
//  MockUserReviewsRepository.swift
//  MovieAppTests
//
//  Created by Vishmita Shetty on 25/04/21.
//

import Foundation
@testable import MovieApp

class MockUserReviewsRepository: UserReviewsRepositoryProtocol {
    
    static let shared = MockUserReviewsRepository()
    var userReviewResponse: UserReviewsResponse?
    
    private init() {}
    
    func getReviews(movieId: Int?, pageNo: Int, completionHandler: @escaping (Result<UserReviewsResponse, TaskError>) -> Void) {
        
        let path = Bundle(for: type(of: self)).path(forResource: "UserReviewResponse", ofType: "json")
        ProcessDummyJSON.sharedObject.processJSONResponse(path: path) { (result: Result<UserReviewsResponse, TaskError>) in
            switch result {
            case .success(let response, _):
                self.userReviewResponse = response
            case .failure:
                break
            }
            completionHandler(result)
        }
    }
    
    func getUserReviewResponse() -> UserReviewsResponse? {
        return userReviewResponse
    }
}
