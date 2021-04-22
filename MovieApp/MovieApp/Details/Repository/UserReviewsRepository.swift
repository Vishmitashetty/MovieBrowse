//
//  UserReviewsRepository.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation

protocol UserReviewsRepositoryProtocol {
    func getReviews(movieId: Int?, pageNo: Int, completionHandler: @escaping (Result<UserReviewsResponse, TaskError>) -> Void)
}

class UserReviewsRepository: UserReviewsRepositoryProtocol {
    
    static let shared = UserReviewsRepository()
    private init() {}
    
    func getReviews(movieId: Int?, pageNo: Int, completionHandler: @escaping (Result<UserReviewsResponse, TaskError>) -> Void) {
        let task = HTTPTask()
        guard
            let movieId = movieId else { return }
        
        task.GET(api: MovieApiRoute.reviews(movieId: String(movieId), pageNo: pageNo)) { (result: Result<UserReviewsResponse, TaskError>) -> Void in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
}
