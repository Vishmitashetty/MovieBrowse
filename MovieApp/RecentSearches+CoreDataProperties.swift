//
//  RecentSearches+CoreDataProperties.swift
//  MovieApp
//
//  Created by Vishmita Shetty on 25/04/21.
//
//

import Foundation
import CoreData


extension RecentSearches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearches> {
        return NSFetchRequest<RecentSearches>(entityName: "RecentSearches")
    }

    @NSManaged public var movieName: String?
    @NSManaged public var movieId: Int64

}

extension RecentSearches : Identifiable {

}
