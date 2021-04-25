//
//  RecentSearches+CoreDataClass.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//
//

import Foundation
import CoreData

@objc(RecentSearches)
public class RecentSearches: NSManagedObject {
    static let entityName = "RecentSearches"

    func insertRecentSearch(movieId: Int64, movieName: String) {
        self.movieName = movieName
        self.movieId = movieId
        self.date = Date()
    }
}
