//
//  UserReviewsResponse.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 22/04/21.
//

import Foundation

struct UserReviewsResponse: Codable {
    let id: Int?
    let page: Int?
    let results: [UserReview]
    let totalPages: Int?
    let totalResults: Int?
}

struct UserReview: Codable {
    let author: String?
    let content: String?
    let createdAt: String?
    let id: String?
    let url: String?
    let authorDetails: AuthorDetails?
}

struct AuthorDetails: Codable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Float?
}
